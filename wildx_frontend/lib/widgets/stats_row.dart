import 'package:flutter/material.dart';
import '../models/user_stats.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_decorations.dart';

class StatsRow extends StatelessWidget {
  final UserStats stats;

  const StatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: AppDecorations.card,
      child: Row(
        children: [
          StatItem(
            value: stats.sightings.toString(),
            label: 'Sightings',
            color: AppColors.blue,
          ),
          const _VerticalDivider(),
          StatItem(
            value: stats.badges.toString(),
            label: 'Badges',
            color: AppColors.amber,
          ),
          const _VerticalDivider(),
          StatItem(
            value: stats.parks.toString(),
            label: 'Parks',
            color: AppColors.cyan,
          ),
        ],
      ),
    );
  }
}
