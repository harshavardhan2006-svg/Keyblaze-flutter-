import 'package:flutter/material.dart';

class NeonButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const NeonButton({Key? key, required this.child, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final glow = Theme.of(context).primaryColor.withOpacity(0.18);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.9)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
