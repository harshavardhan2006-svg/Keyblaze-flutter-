import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../models/leaderboard_entry.dart';
import '../models/user_model.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<LeaderboardEntry> entries = [];
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    final fetchedEntries = await StorageService.getLeaderboard();
    final fetchedUser = await StorageService.getUser();
    setState(() {
      entries = fetchedEntries;
      user = fetchedUser;
    });
  }

  Future<void> _resetLeaderboard() async {
    await StorageService.clearLeaderboard();
    await _loadLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('🏆 Leaderboard'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white70),
            onPressed: _loadLeaderboard,
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
            onPressed: _resetLeaderboard,
          ),
        ],
      ),
      body: entries.isEmpty
          ? const Center(
        child: Text(
          'No scores yet.\nPlay to get on the board!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),
      )
          : RefreshIndicator(
        onRefresh: _loadLeaderboard,
        color: Colors.purpleAccent,
        backgroundColor: Colors.black,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: entries.length,
          itemBuilder: (_, i) {
            final e = entries[i];
            final isTop3 = i < 3;
            final isMe = user != null && e.name == user!.username;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isMe
                    ? const Color(0xFF2B1B4D)
                    : const Color(0xFF121212),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isMe
                      ? const Color(0xFFA259FF)
                      : Colors.grey.withOpacity(0.2),
                  width: 1.2,
                ),
                boxShadow: isTop3
                    ? [
                  BoxShadow(
                    color: [
                      Colors.amber,
                      Colors.grey,
                      const Color(0xFFCD7F32)
                    ][i]
                        .withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  )
                ]
                    : [],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isTop3
                      ? [
                    Colors.amber,
                    Colors.grey,
                    const Color(0xFFCD7F32)
                  ][i]
                      : Colors.grey.shade800,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                title: Text(
                  e.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                    isMe ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  'WPM: ${e.wpm.toStringAsFixed(0)} | Accuracy: ${e.accuracy.toStringAsFixed(0)}%',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  '+${e.xp} XP',
                  style: const TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: user == null
          ? null
          : Container(
        color: const Color(0xFF0F0F0F),
        padding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'You: ${user!.username}',
              style:
              const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Text(
              'Lvl ${user!.level} | XP ${user!.totalXp}',
              style:
              const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
