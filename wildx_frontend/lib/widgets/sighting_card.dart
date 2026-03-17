import 'package:flutter/material.dart';
import '../models/sighting.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_decorations.dart';

class SightingCard extends StatelessWidget {
  final Sighting sighting;
  final VoidCallback? onTap;

  const SightingCard({super.key, required this.sighting, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: AppDecorations.card,
        child: Row(
          children: [
            _AnimalThumbnail(imageUrl: sighting.imageUrl),
            const SizedBox(width: 14),
            _SightingInfo(sighting: sighting),
            _CategoryBadge(category: sighting.category),
          ],
        ),
      ),
    );
  }
}