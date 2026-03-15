import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/wildx_theme.dart';

class XPProgressCard extends StatelessWidget {
  final UserModel user;
  final Animation<double> animation;

  const XPProgressCard({
    super.key,
    required this.user,
    required this.animation,
  });

  static const _levels = [
    WildXLevel.explorer,
    WildXLevel.ranger,
    WildXLevel.guardian,
  ];

  static const _labels = ['Explorer', 'Ranger', 'Guardian'];

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
                Icons.military_tech_rounded,
                color: WildXTheme.amber,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Level: ${user.levelLabel}',
                style: WildXTheme.displayFont.copyWith(
                  fontSize: 15,
                  color: WildXTheme.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: WildXTheme.mintGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${user.xp} / ${user.xpForNextLevel} XP',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: WildXTheme.forestGreen,
                  ),
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