import 'package:flutter/material.dart';
import '../models/park.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_decorations.dart';
import '../constants/app_strings.dart';

class FeaturedParkCard extends StatelessWidget {
  final Park park;
  final VoidCallback? onExplore;

  const FeaturedParkCard({
    super.key,
    required this.park,
    this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: AppDecorations.cardLg,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _ParkImage(imageUrl: park.imageUrl),
            _DarkOverlay(),
            Positioned(
              left: 14,
              bottom: 14,
              right: 14,
              child: _CardContent(park: park, onExplore: onExplore),
            ),
          ],
        ),
      ),
    );
  }
}
// ── Sub-widgets ─────────────────────────────────────────────────────────

class _ParkImage extends StatelessWidget {
  final String imageUrl;
  const _ParkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: AppColors.primaryDark,
        child: const Icon(Icons.park, color: Colors.white54, size: 60),
      ),
      loadingBuilder: (_, child, progress) {
        if (progress == null) return child;
        return Container(
          color: AppColors.primaryDark,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white54),
          ),
        );
      },
    );
  }
}
class _DarkOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.72)],
          stops: const [0.3, 1.0],
        ),
      ),
    );
  }
}
class _CardContent extends StatelessWidget {
  final Park park;
  final VoidCallback? onExplore;
  const _CardContent({required this.park, this.onExplore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _ParkLabel(name: park.name),
        _ExploreButton(onTap: onExplore),
      ],
    );
  }
}
class _ParkLabel extends StatelessWidget {
  final String name;
  const _ParkLabel({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            AppStrings.featuredPark,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(name, style: AppTextStyles.cardTitle),
      ],
    );
  }
}
class _ExploreButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _ExploreButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Text(
              AppStrings.explore,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward, size: 14, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}