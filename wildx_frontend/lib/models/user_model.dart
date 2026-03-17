enum WildXLevel { explorer, ranger, guardian }

class BadgeModel {
  final String title;
  final String iconAsset; // e.g. 'assets/icons/first_sighting.png'
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