import 'package:flutter/material.dart';
import '../widgets/about/about_app_bar.dart';
import '../widgets/about/app_logo_header.dart';
import '../widgets/about/mission_section.dart';
import '../widgets/about/key_features_section.dart';
import '../widgets/about/conservation_partner_section.dart';
import '../widgets/about/contact_us_section.dart';
import '../widgets/about/about_footer.dart';

/// The main entry point for the "About Us" page.
/// Orchestrates various sections to provide a comprehensive overview of WildX.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light greenish-grey background to match the nature theme
      backgroundColor: const Color(0xFFF0F7F4),
      appBar: const AboutAppBar(),
      body: SingleChildScrollView(
        // Ensures the screen is scrollable on smaller devices or when content overflows
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            AppLogoHeader(),
            SizedBox(height: 14), // Consistent spacing between sections
            MissionSection(),
            SizedBox(height: 14),
            KeyFeaturesSection(),
            SizedBox(height: 14),
            ConservationPartnerSection(),
            SizedBox(height: 14),
            ContactUsSection(),
            SizedBox(height: 20),
            AboutFooter(),
            SizedBox(height: 24), // Bottom padding for a clean finish
          ],
        ),
      ),
    );
  }
}