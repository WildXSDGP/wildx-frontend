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
  final List<String> imageUrls;
  final String description;

  String get imageUrl => imageUrls.first;

  const Accommodation({
    required this.id,
    required this.name,
    required this.parkName,
    required this.pricePerNight,
    required this.distanceFromGate,
    required this.rating,
    required this.isEcoFriendly,
    required this.isFamilyFriendly,
    required this.imageUrls,
    required this.description,
  });
}
