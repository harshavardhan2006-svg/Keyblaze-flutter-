import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../models/user_model.dart';
import '../widgets/xp_bar.dart';
import '../widgets/neon_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final storedUser = await StorageService.getUser();
    setState(() => user = storedUser);
  }

  Future<void> _editName() async {
    if (user == null) return;
    final controller = TextEditingController(text: user!.username);
    final res = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Edit Username',
          style: TextStyle(color: Color(0xFFEAEAEA)),
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter username',
            hintStyle: TextStyle(color: Colors.white54),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (res != null && res.isNotEmpty) {
      final updated = UserModel(
        username: res,
        totalXp: user!.totalXp,
        level: user!.level,
        streakDays: user!.streakDays,
        highestWpm: user!.highestWpm,
        bestAccuracy: user!.bestAccuracy,
      );
      await StorageService.saveUser(updated);
      setState(() => user = updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('KeyBlaze — ${user!.username}',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFFA259FF),
                  child: Text(
                    user!.username[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user!.username,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFFEAEAEA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: _editName,
                            icon: const Icon(Icons.edit, size: 18, color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // ✅ XPBar with correct parameters
                      XPBar(
                        xp: user!.totalXp,
                        totalXp: user!.level * 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Buttons
            NeonButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.flash_on),
                  SizedBox(width: 8),
                  Text('Start Typing Battle'),
                ],
              ),
              onPressed: () => Navigator.of(context).pushNamed('/arena'),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: NeonButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.emoji_events),
                        SizedBox(width: 8),
                        Text('Leaderboard'),
                      ],
                    ),
                    onPressed: () => Navigator.of(context).pushNamed('/leaderboard'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NeonButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.bar_chart),
                        SizedBox(width: 8),
                        Text('Stats'),
                      ],
                    ),
                    onPressed: () => Navigator.of(context).pushNamed('/stats'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Spacer(),
            const Center(
              child: Text(
                '🔥 Daily Tip: Focus on accuracy first. Speed will follow.',
                style: TextStyle(color: Color(0xFF777777), fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
