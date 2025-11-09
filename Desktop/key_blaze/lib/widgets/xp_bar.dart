import 'package:flutter/material.dart';

class XPBar extends StatelessWidget {
  final int xp;
  final int totalXp;

  const XPBar({
    required this.xp,
    required this.totalXp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (xp / totalXp).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'XP Progress',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: const Color(0xFF1E1E1E),
            color: const Color(0xFFA259FF),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$xp XP',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            Text(
              'Next: $totalXp XP',
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
