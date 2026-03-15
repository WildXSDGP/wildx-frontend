import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/wildx_theme.dart';

class AchievementGrid extends StatelessWidget {
  final List<BadgeModel> badges;

  const AchievementGrid({super.key, required this.badges});

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
                Icons.workspace_premium_rounded,
                color: WildXTheme.amber,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Badges & Achievements',
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