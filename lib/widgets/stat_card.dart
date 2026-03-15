import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/wildx_theme.dart';

/// A single stat card showing an icon, numeric value, and label.
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: WildXTheme.cardDecoration,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: WildXTheme.displayFont.copyWith(
                fontSize: 22,
                color: WildXTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: WildXTheme.textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Builds the 3-card stat row from a UserModel.
class StatCardRow extends StatelessWidget {
  final UserModel user;

  const StatCardRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatCard(
          label: 'Sightings',
          value: user.sightingsCount.toString(),
          icon: Icons.visibility_rounded,
          iconColor: WildXTheme.forestGreen,
        ),
        const SizedBox(width: 12),
        StatCard(
          label: 'Parks',
          value: user.parksVisited.toString(),
          icon: Icons.park_rounded,
          iconColor: WildXTheme.sky,
        ),
        const SizedBox(width: 12),
        StatCard(
          label: 'Photos',
          value: user.photosCount.toString(),
          icon: Icons.camera_alt_rounded,
          iconColor: WildXTheme.amber,
        ),
      ],
    );
  }
}