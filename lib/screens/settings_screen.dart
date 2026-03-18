// lib/screens/settings/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:wildx_gallery/widgets/setting/feedback_sheet.dart';
import 'package:wildx_gallery/widgets/setting/logout_button.dart';
import 'package:wildx_gallery/widgets/setting/settings_footer.dart';
import 'package:wildx_gallery/widgets/setting/settings_tile.dart';
import 'package:wildx_gallery/widgets/setting/profile_card.dart';
import 'package:wildx_gallery/widgets/setting/section_card.dart';
import 'package:wildx_gallery/widgets/setting/help_sheet.dart';
import '../models/user_profile.dart';
import '../data/settings_data.dart';

/**
 * SettingsScreen acts as a central hub for user preferences and support.
 * It uses a modular approach by composing smaller, specialized widgets.
 */
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Dummy user profile data for the UI. 
  // In a real app, this would come from an Auth Provider or Database.
  static const _profile = UserProfile(
    displayName: 'Wildlife Explorer',
    email:        'explorer@wildlanka.com',
    badge:        'Expert Ranger',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7), // Light grey background like iOS
      appBar: _buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ── User Profile Section ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ProfileCard(
              profile: _profile,
              onTap: () => _showComingSoon(context, 'Edit Profile'),
            ),
          ),

          const SizedBox(height: 24),

          // ── General Application Settings ──────────────────────────────
          // Grouped inside a SectionCard for a clean, inset look.
          SectionCard(
            items: [
              SettingsTile(
                icon:      mainSettingsItems[0].icon,
                iconColor: mainSettingsItems[0].iconColor,
                label:     mainSettingsItems[0].label,
                onTap:     () => _showComingSoon(context, 'Notifications'),
              ),
              SettingsTile(
                icon:      mainSettingsItems[1].icon,
                iconColor: mainSettingsItems[1].iconColor,
                label:     mainSettingsItems[1].label,
                onTap:     () => _showComingSoon(context, 'Language'),
              ),
              SettingsTile(
                icon:      mainSettingsItems[2].icon,
                iconColor: mainSettingsItems[2].iconColor,
                label:     mainSettingsItems[2].label,
                onTap:     () => _showComingSoon(context, 'Privacy & Security'),
              ),
              SettingsTile(
                icon:      mainSettingsItems[3].icon,
                iconColor: mainSettingsItems[3].iconColor,
                label:     mainSettingsItems[3].label,
                onTap:     () => _showAboutDialog(context),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Help & Community Feedback ─────────────────────────────────
          SectionCard(
            items: [
              SettingsTile(
                icon:      helpSettingsItems[0].icon,
                iconColor: helpSettingsItems[0].iconColor,
                label:     helpSettingsItems[0].label,
                onTap:     () => HelpSheet.show(context), // Opens bottom sheet
              ),
              SettingsTile(
                icon:      helpSettingsItems[1].icon,
                iconColor: helpSettingsItems[1].iconColor,
                label:     helpSettingsItems[1].label,
                onTap:     () => FeedbackSheet.show(context), // Opens feedback form
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Authentication Section ───────────────────────────────────
          LogoutButton(onTap: () => _showLogoutDialog(context)),

          const SizedBox(height: 32),

          // ── App Version & Footer Info ────────────────────────────────
          const SettingsFooter(),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ── UI Helper: Custom Styled App Bar ─────────────────────────────────
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1A1A2E), size: 20),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Settings',
        style: TextStyle(
          color: Color(0xFF1A1A2E),
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xFFE5E5EA), height: 0.5),
      ),
    );
  }

  // ── Interaction: Toast/SnackBar for unbuilt features ──────────────────
  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature — coming soon'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFF1A1A2E),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ── Interaction: Confirmation Dialog for Logout ───────────────────────
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
        content: const Text(
          'Are you sure you want to logout of your WildX account?',
          style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF007AFF))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Logout',
                style: TextStyle(color: Color(0xFFFF3B30), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ── Interaction: Information Modal for the App ────────────────────────
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Text('🌿', style: TextStyle(fontSize: 22)),
            SizedBox(width: 8),
            Text('About WildX',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
          ],
        ),
        content: const Text(
          'WildX v1.0.0\n\nWildX helps wildlife enthusiasts explore and document Sri Lanka\'s incredible biodiversity. Built with ❤️ for nature.\n\n© 2026 WildX. All rights reserved.',
          style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF007AFF))),
          ),
        ],
      ),
    );
  }
}