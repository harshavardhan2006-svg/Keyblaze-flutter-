import 'dart:async';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import '../utils/typing_utils.dart';
import '../widgets/stat_card.dart';
import '../widgets/xp_bar.dart';
import '../services/storage_service.dart';
import '../models/user_model.dart';
import '../models/leaderboard_entry.dart';
import '../models/achievements.dart';
import '../models/game_record.dart';

class ArenaScreen extends StatefulWidget {
  const ArenaScreen({super.key});

  @override
  State<ArenaScreen> createState() => _ArenaScreenState();
}

class _ArenaScreenState extends State<ArenaScreen> {
  late String level;
  List<String> targets = [];
  int currentIndex = 0;
  final TextEditingController _ctrl = TextEditingController();
  bool started = false;
  DateTime? startTime;
  Timer? _timer;
  int elapsedSeconds = 0;
  int totalTyped = 0;
  int correctChars = 0;
  int errors = 0;
  double wpm = 0;
  double accuracy = 100;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    level = (args != null && args['level'] != null) ? args['level'] : 'easy';
    _prepareTargets();
  }

  void _prepareTargets() {
    targets = getTargetForLevel(level);
    currentIndex = 0;
    _resetStats();
  }

  void _resetStats() {
    _ctrl.clear();
    started = false;
    startTime = null;
    elapsedSeconds = 0;
    totalTyped = 0;
    correctChars = 0;
    errors = 0;
    wpm = 0;
    accuracy = 100;
    _timer?.cancel();
    setState(() {});
  }

  void _startTimer() {
    startTime = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() =>
      elapsedSeconds = DateTime.now().difference(startTime!).inSeconds);
      _recalculate();
    });
  }

  void _recalculate() {
    final mins = elapsedSeconds / 60.0;
    final words = correctChars / 5.0;
    wpm = mins > 0 ? (words / mins) : 0;
    accuracy = totalTyped > 0 ? (correctChars / totalTyped) * 100.0 : 100.0;
    setState(() {});
  }

  void _onChanged(String v) {
    if (!started && v.isNotEmpty) {
      started = true;
      _startTimer();
    }
    totalTyped = v.length;
    final target = targets[currentIndex];
    int correct = 0;
    int errs = 0;
    final minlen = v.length < target.length ? v.length : target.length;
    for (int i = 0; i < minlen; i++) {
      if (v[i] == target[i]) {
        correct++;
      } else {
        errs++;
      }
    }
    if (v.length > target.length) errs += v.length - target.length;
    correctChars = correct;
    errors = errs;
    _recalculate();
    if (v == target) _onComplete();
  }

  Future<void> _onComplete() async {
    _timer?.cancel();
    _confettiController.play();

    final record = GameRecord(
      playedAt: DateTime.now(),
      level: level,
      wpm: double.parse(wpm.toStringAsFixed(2)),
      timeSeconds: elapsedSeconds > 0 ? elapsedSeconds : 1,
      errors: errors,
      accuracy: double.parse(accuracy.toStringAsFixed(2)),
    );

    final user = await StorageService.getUser();
    if (user == null) return;

    final xpEarned = (wpm * (accuracy / 10)).round();
    final newXp = user.totalXp + xpEarned;
    final newLevel = (newXp / 100).floor();

    final newUser = UserModel(
      username: user.username,
      totalXp: newXp,
      level: newLevel,
      streakDays: user.streakDays + 1,
      highestWpm: wpm > user.highestWpm ? wpm : user.highestWpm,
      bestAccuracy: accuracy > user.bestAccuracy ? accuracy : user.bestAccuracy,
    );

    await StorageService.saveUser(newUser);
    await StorageService.addLeaderboard(
      LeaderboardEntry(
        name: newUser.username,
        xp: newUser.totalXp,
        wpm: newUser.highestWpm,
        accuracy: newUser.bestAccuracy,
      ),
    );

    final ach = await StorageService.getAchievements();
    final updated = Achievements(
      firstGame: true,
      streak3: (newUser.streakDays >= 3) ? true : ach.streak3,
      level10: newUser.level >= 10,
      wpm70: newUser.highestWpm >= 70,
      perfect100: (accuracy == 100),
    );
    await StorageService.saveAchievements(updated);

    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('🔥 Round Complete!',
            style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('WPM: ${record.wpm}', style: const TextStyle(color: Colors.white)),
            Text('Accuracy: ${record.accuracy}%',
                style: const TextStyle(color: Colors.white)),
            Text('XP Gained: +$xpEarned',
                style: const TextStyle(color: Colors.white)),
            Text('Errors: ${record.errors}',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _prepareTargets();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/menu');
            },
            child: const Text('Back to Menu',
                style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _confettiController.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final target = targets.isNotEmpty ? targets[currentIndex] : '';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Arena — ${level.toUpperCase()}'),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ✅ Responsive WPM, Accuracy, Time, Errors Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 600;
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: isWide ? 4 : 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: isWide ? 2.8 : 2.1,
                        children: [
                          StatCard(title: 'WPM', value: wpm.toStringAsFixed(0), icon: Icons.speed),
                          StatCard(title: 'Accuracy', value: '${accuracy.toStringAsFixed(0)}%', icon: Icons.percent),
                          StatCard(title: 'Time', value: '${elapsedSeconds}s', icon: Icons.timer),
                          StatCard(title: 'Errors', value: errors.toString(), icon: Icons.error_outline),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 18),
                  Card(
                    color: const Color(0xFF121212),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        target,
                        style: const TextStyle(fontSize: 20, color: Colors.white, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _ctrl,
                    maxLines: null,
                    onChanged: _onChanged,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: const Color(0xFFA259FF),
                    decoration: InputDecoration(
                      hintText: 'Start typing here...',
                      filled: true,
                      fillColor: const Color(0xFF1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  XPBar(xp: (wpm * (accuracy / 10)).round(), totalXp: 100),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.05,
              numberOfParticles: 25,
              gravity: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
