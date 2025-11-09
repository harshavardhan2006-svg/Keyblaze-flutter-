import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool useCyan;

  @override
  void initState() {
    super.initState();
    useCyan = StorageService.getThemeCyan();
  }

  Future<void> _toggleTheme(bool v) async {
    await StorageService.setThemeCyan(v);
    setState(() => useCyan = v);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          ListTile(
            title: const Text('Theme: Neon Cyan'),
            trailing: Switch(value: useCyan, onChanged: _toggleTheme),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text('Reset All Data'),
            subtitle: const Text('This clears progress & leaderboard (local only).'),
            trailing: ElevatedButton(
              onPressed: () async {
                await StorageService.resetAll();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data reset')));
              },
              child: const Text('Reset'),
            ),
          ),
        ]),
      ),
    );
  }
}
