import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'routes/app_routes.dart';
import 'screens/accommodation_detail_screen.dart';
import 'screens/accommodation_screen.dart';
import 'screens/booking_confirmation_screen.dart';
import 'screens/booking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: AppRoutes.accommodations,
      routes: {
        AppRoutes.accommodations: (_) => const AccommodationScreen(),
        AppRoutes.accommodationDetail: (_) => const AccommodationDetailScreen(),
        AppRoutes.booking: (_) => const BookingScreen(),
        AppRoutes.bookingConfirmation: (_) => const BookingConfirmationScreen(),
      },
    );
  }
}
