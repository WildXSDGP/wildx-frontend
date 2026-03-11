import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/accommodation.dart';
import '../widgets/app_badge.dart';

class AccommodationDetailScreen extends StatelessWidget {
  const AccommodationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item =
        ModalRoute.of(context)!.settings.arguments as Accommodation;

    return Scaffold(
      backgroundColor: kGreenSoft,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroImage(context, item),
            _buildContentCard(item),
          ],
        ),
      ),
    );
  }

  // ── Hero image with back button and badges ──
  Widget _buildHeroImage(BuildContext context, Accommodation item) {
    return Stack(
      children: [
        // Image
        SizedBox(
          height: 280,
          width: double.infinity,
          child: Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: kGreenSoft,
              child: const Icon(Icons.image_not_supported,
                  size: 64, color: kGreen),
            ),
          ),
        ),

        // Bottom gradient overlay
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.55),
                ],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),

        // Back button (top-left)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black38,
              child: Icon(Icons.arrow_back_ios_new,
                  size: 14, color: Colors.white),
            ),
          ),
        ),

        // Eco / Family badges (top-right)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 16,
          child: Row(
            children: [
              if (item.isEcoFriendly) AppBadge(label: '🌿 Eco', color: kGreen),
              if (item.isEcoFriendly && item.isFamilyFriendly)
                const SizedBox(width: 6),
              if (item.isFamilyFriendly)
                AppBadge(label: '👨‍👩‍👧 Family', color: kGreenLight),
            ],
          ),
        ),

        // Name overlay at bottom of image
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Text(
            item.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(color: Colors.black54, blurRadius: 6),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Main content card ───────────────────────
  Widget _buildContentCard(Accommodation item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: kGreen.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceRatingRow(item),
          const SizedBox(height: 12),
          _buildParkRow(item),
          const Divider(height: 28),
          _buildDescriptionSection(item),
          const SizedBox(height: 24),
          _buildBookButton(),
        ],
      ),
    );
  }

  // ── Price + Rating row ──────────────────────
  Widget _buildPriceRatingRow(Accommodation item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LKR ${item.pricePerNight.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
            const Text(
              'per night',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        // Rating badge
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.star_rounded,
                  color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                item.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Park name row ───────────────────────────
  Widget _buildParkRow(Accommodation item) {
    return Row(
      children: [
        const Icon(Icons.park_outlined, size: 16, color: kGreenLight),
        const SizedBox(width: 6),
        Text(
          item.parkName,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.location_on_outlined,
            size: 16, color: kGreenLight),
        const SizedBox(width: 4),
        Text(
          '${item.distanceFromGate} km from gate',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // ── Description section ─────────────────────
  Widget _buildDescriptionSection(Accommodation item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kGreen,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // ── Book Now button ─────────────────────────
  Widget _buildBookButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kGreen,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          // TODO: Implement booking flow
        },
        child: const Text(
          'Book Now',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
