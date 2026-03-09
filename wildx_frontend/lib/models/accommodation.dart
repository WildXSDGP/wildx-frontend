enum SortOption { topRated, closest, budget, familyFriendly }

class Accommodation {
  final String id;
  final String name;
  final String parkName;
  final double pricePerNight;
  final double distanceFromGate;
  final double rating;
  final bool isEcoFriendly;
  final bool isFamilyFriendly;
  final String imageUrl;
  final String description;

  const Accommodation({
    required this.id,
    required this.name,
    required this.parkName,
    required this.pricePerNight,
    required this.distanceFromGate,
    required this.rating,
    required this.isEcoFriendly,
    required this.isFamilyFriendly,
    required this.imageUrl,
    required this.description,
  });
}
