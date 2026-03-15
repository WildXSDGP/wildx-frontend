import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/wildx_theme.dart';

class TopParksCard extends StatelessWidget {
  final List<ParkVisit> parks;

  const TopParksCard({super.key, required this.parks});

  static const _medalColors = [
    Color(0xFFFFD700),
    Color(0xFFB0C4DE),
    Color(0xFFCD7F32),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: WildXTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.map_rounded,
                color: WildXTheme.forestGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Top Parks Visited',
                style: WildXTheme.displayFont.copyWith(
                  fontSize: 15,
                  color: WildXTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
        ],
      ),
    );
  }
}