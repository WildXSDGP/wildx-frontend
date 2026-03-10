import 'package:flutter/material.dart';
import 'widgets/about_app_bar.dart';
import 'widgets/app_logo_header.dart';
import 'widgets/mission_section.dart';
import 'widgets/key_features_section.dart';
import 'widgets/conservation_partner_section.dart';
import 'widgets/contact_us_section.dart';
import 'widgets/about_footer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F4),
      appBar: const AboutAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            AppLogoHeader(),
            SizedBox(height: 14),
            MissionSection(),
            SizedBox(height: 14),
            KeyFeaturesSection(),
            SizedBox(height: 14),
            ConservationPartnerSection(),
            SizedBox(height: 14),
            ContactUsSection(),
            SizedBox(height: 20),
            AboutFooter(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
