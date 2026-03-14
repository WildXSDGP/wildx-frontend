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
    // Initializing the data service
    final service = WildXDataService();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Fixed Header: Contains branding and notification/settings actions
          const AppHeader(),

          // Main Scrollable Area
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to show customized SnackBar feedback
  void _snack(BuildContext context, String message,
      {Color color = AppColors.primary}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}