// lib/widgets/settings/feedback/star_rating.dart

import 'package:flutter/material.dart';

/**
 * A row of interactive star icons that allow users to select a rating.
 * It highlights stars up to the selected value and provides tactile feedback.
 */
class StarRating extends StatelessWidget {
  final int rating; // Current rating value (0 to 5)
  final ValueChanged<int> onRatingChanged; // Callback to notify the parent of a change

  const StarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        // Index starts at 0, so we add 1 to check against the rating
        final starValue = index + 1;
        final isFilled = starValue <= rating;

        return GestureDetector(
          onTap: () => onRatingChanged(starValue),
          child: AnimatedScale(
            // Adds a subtle "pop" animation when a star is selected
            scale: isFilled ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 32,
                color: isFilled 
                    ? const Color(0xFFFFCC00) // Gold for filled stars
                    : Colors.grey[300],        // Light grey for empty stars
              ),
            ),
          ),
        );
      }),
    );
  }
}