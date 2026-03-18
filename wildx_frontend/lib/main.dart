// ============================================================
//  WildX — App Entry Point
//  lib/main.dart
// ============================================================

import 'package:flutter/material.dart';

import 'data/sample_user.dart';
import 'screens/profile_screen.dart';
import 'theme/wildx_theme.dart';

void main() => runApp(const WildXApp());

class WildXApp extends StatelessWidget {
  const WildXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildX',
      debugShowCheckedModeBanner: false,
      theme: WildXTheme.materialTheme,
      // Swap kSampleUser with your real logged-in UserModel
      home: ProfileScreen(user: kSampleUser),
    );
  }
}
