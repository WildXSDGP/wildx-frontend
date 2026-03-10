import 'package:flutter/material.dart';
import '../data/about_data.dart';
import 'section_card.dart';

class ConservationPartnerSection extends StatelessWidget {
  const ConservationPartnerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      color: const Color(0xFFFFFDE7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            conservationPartnerTitle,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            conservationPartnerSubtitle,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF555555),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            conservationPartnerBody,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
