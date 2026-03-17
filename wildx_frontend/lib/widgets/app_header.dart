import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_decorations.dart';
import '../constants/app_strings.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 280),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.headerGradient,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.appName, style: AppTextStyles.appTitle),
              SizedBox(height: 2),
              Text(AppStrings.appTagline, style: AppTextStyles.appSubtitle),
            ],
          ),
          Row(
            children: [
              _HeaderIconButton(
                icon: Icons.notifications_outlined,
                onTap: () => _navigateTo(
                  context,
                  const _PlaceholderScreen(
                    title: 'Notifications',
                    icon: Icons.notifications_outlined,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _HeaderIconButton(
                icon: Icons.settings_outlined,
                onTap: () => _navigateTo(
                  context,
                  const _PlaceholderScreen(
                    title: 'Settings',
                    icon: Icons.settings_outlined,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}