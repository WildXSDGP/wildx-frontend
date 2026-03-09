import 'package:flutter/material.dart';

import '../app_colors.dart';

class BarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const BarButton(
      {super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: kGreenLight.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: kGreen),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: kGreen)),
          ],
        ),
      ),
    );
  }
}
