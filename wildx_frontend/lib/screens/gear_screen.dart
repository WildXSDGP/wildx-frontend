import 'package:flutter/material.dart';
import '../theme/safari_theme.dart';

class GearScreen extends StatelessWidget {
  const GearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SafariTheme.background,
      appBar: AppBar(
        backgroundColor: SafariTheme.forestGreen,
        foregroundColor: Colors.white,
        title: const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.w800)),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Settings Coming Soon...',
          style: TextStyle(color: SafariTheme.textSecondary, fontSize: 16),
        ),
      ),
    );
  }
}
