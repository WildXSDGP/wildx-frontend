import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final Color color;

  const AppBadge({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }
}
