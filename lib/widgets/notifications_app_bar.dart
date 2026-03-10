import 'package:flutter/material.dart';

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: const Color(0xFF1A1A2E),
            iconSize: 20,
          ),
          const SizedBox(width: 4),
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}
