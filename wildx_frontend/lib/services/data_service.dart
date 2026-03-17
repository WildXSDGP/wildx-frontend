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

  // ── Featured Park ──────────────────────────────────────────────
  Park get featuredPark => const Park(
        id: 'yala',
        name: 'Yala National Park',
        location: 'Southern Province',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Sri_Lankan_elephant_%28Elephas_maximus_maximus%29.jpg/1280px-Sri_Lankan_elephant_%28Elephas_maximus_maximus%29.jpg',
        description:
            "Sri Lanka's most visited national park, famous for leopards and elephants.",
        animalCount: 215,
        isFeatured: true,
      );

  // ── User Stats ─────────────────────────────────────────────────
  UserStats get userStats => const UserStats(
        sightings: 24,
        badges: 3,
        parks: 12,
      );

  // ── All Parks ──────────────────────────────────────────────────
  List<Park> get allParks => [
        featuredPark,
        const Park(
          id: 'wilpattu',
          name: 'Wilpattu National Park',
          location: 'North Western Province',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Leopard_sitting_2.jpg/1280px-Leopard_sitting_2.jpg',
          description: "Largest national park in Sri Lanka, famous for leopards.",
          animalCount: 180,
        ),
        const Park(
          id: 'minneriya',
          name: 'Minneriya National Park',
          location: 'North Central Province',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Sri_Lankan_elephant_%28Elephas_maximus_maximus%29.jpg/1280px-Sri_Lankan_elephant_%28Elephas_maximus_maximus%29.jpg',
          description:
              "Known for The Gathering — the world's largest elephant congregation.",
          animalCount: 160,
        ),
        const Park(
          id: 'udawalawe',
          name: 'Udawalawe National Park',
          location: 'Sabaragamuwa Province',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Sri_Lankan_elephant_%28Elephas_maximus_maximus%29.jpg/1280px-Sri_Lankan_elephant_%28Elephas_maximus_maximus%29.jpg',
          description: "A sanctuary for Sri Lankan elephants near a reservoir.",
          animalCount: 140,
        ),
      ];