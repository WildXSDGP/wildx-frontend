import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'screens/accommodation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.accommodations,
      routes: {
        AppRoutes.accommodations: (_) => const AccommodationScreen(),
        // AppRoutes.accommodationDetail: (_) => const AccommodationDetailScreen(),
      },
    );
  }
}
