import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {
  final String title;
  final bool unlocked;
  const BadgeCard({Key? key, required this.title, required this.unlocked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: unlocked ? Theme.of(context).primaryColor : Colors.transparent),
      ),
      child: Column(
        children: [
          Icon(unlocked ? Icons.emoji_events : Icons.lock, color: unlocked ? Theme.of(context).primaryColor : Colors.grey),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Color(0xFFEAEAEA), fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
