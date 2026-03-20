// ============================================================
//  WildX — App Entry Point
//  lib/main.dart
// ============================================================

import 'package:flutter/material.dart';

import 'data/ranger_data.dart';
import 'screens/explorer_screen.dart';
import 'theme/safari_theme.dart';

void main() => runApp(const WildXApp());

class WildXApp extends StatelessWidget {
  const WildXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildX',
      debugShowCheckedModeBanner: false,
      theme: SafariTheme.materialTheme,
      // Swap kSampleRanger with your real logged-in RangerModel
      home: ExplorerScreen(ranger: kSampleRanger),
    );
  }
}
