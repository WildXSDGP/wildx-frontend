import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/accommodation.dart';
import 'app_badge.dart';

class AccommodationCard extends StatelessWidget {
  final Accommodation item;

  const AccommodationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGreen.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
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
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  item.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: kGreenSoft,
                    child: const Icon(Icons.image_not_supported,
                        size: 50, color: kGreen),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Row(
                  children: [
                    if (item.isEco) AppBadge(label: '🌿 Eco', color: kGreen),
                    if (item.isEco) const SizedBox(width: 6),
                    if (item.isFamily)
                      AppBadge(label: '👨‍👩‍👧 Family', color: kGreenLight),
                  ],
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'LKR ${item.pricePerNight.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: kGreen,
                          ),
                        ),
                        const Text('per night',
                            style:
                                TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.type,
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: kGreenLight),
                    Text(
                      '  ${item.distanceKm} km from park',
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    Text(
                      ' ${item.rating} (${item.reviewCount})',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      // TODO: Navigate to AccommodationDetailScreen
                    },
                    child: const Text('View Details',
                        style: TextStyle(color: Colors.white)),
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
