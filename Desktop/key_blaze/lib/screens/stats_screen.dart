import 'package:flutter/material.dart';
import '../models/game_record.dart';
import '../models/achievements.dart';
import '../services/storage_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<GameRecord> records = [];
  Achievements? achievements;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final recs = await StorageService.getRecords();
    final ach = await StorageService.getAchievements();
    setState(() {
      records = recs;
      achievements = ach;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Stats & Achievements',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: Colors.purpleAccent,
        child: achievements == null
            ? const Center(
          child: CircularProgressIndicator(color: Colors.purpleAccent),
        )
            : SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- ACHIEVEMENTS ----------------
              const Text(
                '🏆 Achievements',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildAchievementsGrid(),

              const SizedBox(height: 28),

              // ---------------- GAME RECORDS ----------------
              const Text(
                '📊 Gameplay History',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              if (records.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: Text(
                      'No gameplay records yet.\nPlay to unlock stats!',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final record = records[index];
                    final xp = ((record.wpm * record.accuracy) / 10).round();
                    return Card(
                      color: const Color(0xFF121212),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(
                          '${record.level.toUpperCase()} — ${record.wpm.toStringAsFixed(1)} WPM',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Accuracy: ${record.accuracy.toStringAsFixed(1)}% | XP: +$xp | Time: ${record.timeSeconds}s',
                          style: const TextStyle(color: Colors.white60),
                        ),
                        trailing: Text(
                          '${record.errors} ❌',
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementsGrid() {
    final a = achievements!;
    final data = [
      {'icon': Icons.sports_esports, 'label': 'First Game', 'unlocked': a.firstGame},
      {'icon': Icons.local_fire_department, 'label': '3-Day Streak', 'unlocked': a.streak3},
      {'icon': Icons.star, 'label': 'Level 10', 'unlocked': a.level10},
      {'icon': Icons.flash_on, 'label': '70+ WPM', 'unlocked': a.wpm70},
      {'icon': Icons.emoji_events, 'label': '100% Accuracy', 'unlocked': a.perfect100},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.8,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        final unlocked = item['unlocked'] as bool;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            color: unlocked ? const Color(0xFF1E1E1E) : const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: unlocked
                  ? const Color(0xFFA259FF)
                  : Colors.grey.withOpacity(0.2),
              width: 1.4,
            ),
            boxShadow: unlocked
                ? [
              BoxShadow(
                color: const Color(0xFFA259FF).withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ]
                : [],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  color: unlocked ? Colors.purpleAccent : Colors.grey,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    item['label'] as String,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: unlocked ? Colors.white : Colors.grey,
                      fontWeight:
                      unlocked ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
