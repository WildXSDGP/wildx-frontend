enum WildXLevel { explorer, ranger, guardian }

class BadgeModel {
  final String title;
  final String iconAsset; 
  final bool earned;

  const BadgeModel({
    required this.title,
    required this.iconAsset,
    this.earned = true,
  });
}

class ParkVisit {
  final String parkName;
  final int visitCount;

  const ParkVisit({required this.parkName, required this.visitCount});
}

class UserModel {
  final String name;
  final String? profileImageUrl;
  final DateTime memberSince;
  final int sightingsCount;
  final int parksVisited;
  final int photosCount;
  final int xp;
  final WildXLevel currentLevel;
  final List<BadgeModel> badges;
  final List<ParkVisit> topParks;

  const UserModel({
    required this.name,
    this.profileImageUrl,
    required this.memberSince,
    required this.sightingsCount,
    required this.parksVisited,
    required this.photosCount,
    required this.xp,
    required this.currentLevel,
    required this.badges,
    required this.topParks,
  });

  // ── Derived helpers ──────────────────────────────────────

  int get xpForCurrentLevel {
    switch (currentLevel) {
      case WildXLevel.explorer:  return 0;
      case WildXLevel.ranger:    return 250;
      case WildXLevel.guardian:  return 700;
    }
  }

  int get xpForNextLevel {
    switch (currentLevel) {
      case WildXLevel.explorer:  return 250;
      case WildXLevel.ranger:    return 700;
      case WildXLevel.guardian:  return 1500;
    }
  }

  double get levelProgress =>
      ((xp - xpForCurrentLevel) / (xpForNextLevel - xpForCurrentLevel))
          .clamp(0.0, 1.0);

  String get levelLabel {
    switch (currentLevel) {
      case WildXLevel.explorer:  return 'Explorer';
      case WildXLevel.ranger:    return 'Ranger';
      case WildXLevel.guardian:  return 'Guardian';
    }
  }

  
}

