import 'package:flutter/material.dart';
import '../data/about_data.dart';

class AboutFooter extends StatelessWidget {
  const AboutFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Terms & Privacy row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Terms of Service',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF2ECC71),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '•',
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF2ECC71),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '© 2025 WildX. All rights reserved.',
          style: TextStyle(fontSize: 12, color: Colors.grey[400]),
        ),
        const SizedBox(height: 4),
        Text(
          madeWithLoveText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
