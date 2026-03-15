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
class _AnimalThumbnail extends StatelessWidget {
  final String imageUrl;
  const _AnimalThumbnail({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        width: 62,
        height: 62,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 62,
          height: 62,
          color: AppColors.primarySurface,
          child: const Icon(Icons.cruelty_free,
              color: AppColors.primary, size: 30),
        ),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return Container(
            width: 62,
            height: 62,
            color: AppColors.primarySurface,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppColors.primary),
              ),
            ),
          );
        },
      ),
    );
  }
}
class _SightingInfo extends StatelessWidget {
  final Sighting sighting;
  const _SightingInfo({required this.sighting});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sighting.animalName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3),
          Text(sighting.parkName, style: AppTextStyles.caption),
          const SizedBox(height: 3),
          Text(sighting.formattedDate, style: AppTextStyles.hint),
        ],
      ),
    );
  }
}
class _CategoryBadge extends StatelessWidget {
  final String category;
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: AppDecorations.primaryBadge,
      child: Text(category, style: AppTextStyles.badge),
    );
  }
}
