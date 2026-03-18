import 'package:flutter/material.dart';
import '../theme/wildx_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WildXTheme.background,
      appBar: AppBar(
        backgroundColor: WildXTheme.forestGreen,
        foregroundColor: Colors.white,
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w800)),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Settings Coming Soon...', style: TextStyle(color: WildXTheme.textSecondary, fontSize: 16)),
      ),
    );
  }
}