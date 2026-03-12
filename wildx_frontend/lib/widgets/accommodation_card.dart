import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/accommodation.dart';
import '../routes/app_routes.dart';
import 'app_badge.dart';

class AccommodationCard extends StatelessWidget {
  final Accommodation item;

  const AccommodationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kSpaceLG),
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(kRadiusLG),
        boxShadow: const [
          BoxShadow(
            color: kShadowColor,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + badges
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(kRadiusLG)),
                child: Image.network(
                  item.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, e, st) => Container(
                    height: 180,
                    color: kGreenSoft,
                    child: const Icon(Icons.image_not_supported,
                        size: 50, color: kGreen),
                  ),
                ),
              ),
              // Gradient overlay at bottom of image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(kRadiusLG)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: kSpaceMD,
                right: kSpaceMD,
                child: Row(
                  children: [
                    if (item.isEcoFriendly) AppBadge(label: '🌿 Eco', color: kGreen),
                    if (item.isEcoFriendly) const SizedBox(width: 6),
                    if (item.isFamilyFriendly)
                      AppBadge(label: '👨‍👩‍👧 Family', color: kGreenLight),
                  ],
                ),
              ),
              // Rating chip on image
              Positioned(
                bottom: kSpaceMD,
                left: kSpaceMD,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kRadiusSM),
                    boxShadow: const [
                      BoxShadow(
                        color: kShadowColor,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 14, color: kAmber),
                      const SizedBox(width: 3),
                      Text(
                        '${item.rating}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: kTextPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(kSpaceLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: kTextPrimary,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: kSpaceXS),
                          Row(
                            children: [
                              const Icon(Icons.park_outlined,
                                  size: 13, color: kGreenLight),
                              const SizedBox(width: kSpaceXS),
                              Text(item.parkName,
                                  style: const TextStyle(
                                      color: kTextSecondary, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'LKR ${item.pricePerNight.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: kGreen,
                          ),
                        ),
                        const Text('per night',
                            style: TextStyle(
                                fontSize: 11, color: kTextHint)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: kSpaceMD),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: kEarthLight),
                    const SizedBox(width: kSpaceXS),
                    Text(
                      '${item.distanceFromGate} km from gate',
                      style:
                          const TextStyle(color: kTextSecondary, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: kSpaceLG),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.accommodationDetail,
                        arguments: item,
                      );
                    },
                    child: const Text('View Details'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
