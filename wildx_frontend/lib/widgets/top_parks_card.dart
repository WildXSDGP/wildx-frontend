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
          ...parks.asMap().entries.map((entry) {
            final idx  = entry.key;
            final park = entry.value;
            final medalColor = _medalColors[idx.clamp(0, 2)];
            return Padding(
              padding: EdgeInsets.only(bottom: idx < parks.length - 1 ? 14 : 0),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: medalColor.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Text(
                        '${idx + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: medalColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      park.parkName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: WildXTheme.textPrimary,
                      ),
                    ),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: WildXTheme.mintGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${park.visitCount} visits',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: WildXTheme.forestGreen,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}