import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/accommodation.dart';
import '../routes/app_routes.dart';
import '../widgets/app_badge.dart';

class AccommodationDetailScreen extends StatefulWidget {
  const AccommodationDetailScreen({super.key});

  @override
  State<AccommodationDetailScreen> createState() =>
      _AccommodationDetailScreenState();
}

class _AccommodationDetailScreenState extends State<AccommodationDetailScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item =
        ModalRoute.of(context)!.settings.arguments as Accommodation;

    return Scaffold(
      backgroundColor: kGreenSoft,
      bottomNavigationBar: _buildStickyBookBar(context, item),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(context, item),
            _buildContentCard(item),
          ],
        ),
      ),
    );
  }

  // ── Image gallery with PageView, dots, back button, badges ──
  Widget _buildImageGallery(BuildContext context, Accommodation item) {
    return Stack(
      children: [
        // PageView slider
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: item.imageUrls.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => Image.network(
              item.imageUrls[index],
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: kGreenSoft,
                child: const Icon(Icons.image_not_supported,
                    size: 64, color: kGreen),
              ),
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
                  Colors.black.withOpacity(0.60),
                ],
                stops: const [0.45, 1.0],
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

        // Name overlay above dots
        Positioned(
          bottom: 32,
          left: 16,
          right: 16,
          child: Text(
            item.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
            ),
          ),
        ),

        // Dot indicators
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(item.imageUrls.length, (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.white
                      : Colors.white.withOpacity(0.50),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
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
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Price + Rating row ──────────────────────
  Widget _buildPriceRatingRow(Accommodation item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
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
        const Icon(Icons.location_on_outlined, size: 16, color: kGreenLight),
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

  // ── Sticky bottom booking bar ───────────────
  Widget _buildStickyBookBar(BuildContext context, Accommodation item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              // Price summary
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LKR ${item.pricePerNight.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kGreen,
                    ),
                  ),
                  const Text(
                    'per night',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Book Now button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.booking,
                      arguments: item,
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month_outlined, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
