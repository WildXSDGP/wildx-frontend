import 'package:flutter/material.dart';

class QuickAccessItem {
  final String label;
  final IconData icon;
  final Color color;
  final String route;

  const QuickAccessItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.route,
  });
}
