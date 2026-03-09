enum SortOption { topRated, closest, budget, familyFriendly }

class Accommodation {
  final String name;
  final String type;
  final double pricePerNight;
  final double distanceKm;
  final double rating;
  final int reviewCount;
  final bool isEco;
  final bool isFamily;
  final String imageUrl;
  final String parkId;

  const Accommodation({
    required this.name,
    required this.type,
    required this.pricePerNight,
    required this.distanceKm,
    required this.rating,
    required this.reviewCount,
    required this.isEco,
    required this.isFamily,
    required this.imageUrl,
    required this.parkId,
  });
}
