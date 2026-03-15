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
