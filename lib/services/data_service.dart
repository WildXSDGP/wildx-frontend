import 'package:flutter/material.dart';
import '../models/park.dart';
import '../models/sighting.dart';
import '../models/user_stats.dart';
import '../models/quick_access_item.dart';
import '../constants/app_strings.dart';
import '../constants/app_routes.dart';
import '../theme/app_colors.dart';

/// Singleton data service — swap with API calls later.
class WildXDataService {
  static final WildXDataService _instance = WildXDataService._internal();
  factory WildXDataService() => _instance;
  WildXDataService._internal();

  // ── User Stats ─────────────────────────────────────────────────
  UserStats get userStats => const UserStats(
        sightings: 24,
        badges: 3,
        parks: 12,
      );
}