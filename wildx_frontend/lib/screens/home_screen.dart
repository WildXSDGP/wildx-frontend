import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../services/data_service.dart';
import '../theme/app_colors.dart';
import '../widgets/app_header.dart';
import '../widgets/featured_park_card.dart';
import '../widgets/stats_row.dart';
import '../widgets/quick_access_grid.dart';
import '../widgets/sighting_card.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = WildXDataService();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Fixed green header (bell + settings navigate)
          const AppHeader(),

          // Scrollable body
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured park card
                  FeaturedParkCard(
                    park: service.featuredPark,
                    onExplore: () => _snack(
                      context,
                      'Exploring ${service.featuredPark.name}…',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Stats row
                  StatsRow(stats: service.userStats),
                  const SizedBox(height: 20),

                  // Quick access grid
                  const SectionHeader(title: AppStrings.quickAccess),
                  const SizedBox(height: 12),
                  QuickAccessGrid(
                    items: service.quickAccessItems,
                    onItemTap: (item) =>
                        _snack(context, '${item.label} opened',
                            color: item.color),
                  ),
                  const SizedBox(height: 20),

                  // Recent sightings
                  SectionHeader(
                    title: AppStrings.recentSightings,
                    actionLabel: AppStrings.viewAll,
                    onAction: () =>
                        _snack(context, 'Viewing all sightings…'),
                  ),
                  const SizedBox(height: 12),

                  ...service.recentSightings.map(
                    (s) => SightingCard(
                      sighting: s,
                      onTap: () =>
                          _snack(context, '${s.animalName} tapped'),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      // ── No bottom navigation bar ──
    );
  }
  void _snack(BuildContext context, String message,
      {Color color = AppColors.primary}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}