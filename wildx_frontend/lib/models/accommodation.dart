enum SortOption { topRated, closest, budget, familyFriendly }

class Accommodation {
  final String id;
  final String name;
  final String parkName;
  final double pricePerNight;
  final double distanceFromGate;
  final String travelTime;
  final int fuelStops;
  final double rating;
  final bool isEcoFriendly;
  final bool isFamilyFriendly;
  final bool hasJeepHire;
  final List<String> imageUrls;
  final String description;

  String get imageUrl => imageUrls.first;

  const Accommodation({
    required this.id,
    required this.name,
    required this.parkName,
    required this.pricePerNight,
    required this.distanceFromGate,
    required this.travelTime,
    required this.fuelStops,
    required this.rating,
    required this.isEcoFriendly,
    required this.isFamilyFriendly,
    required this.hasJeepHire,
    required this.imageUrls,
    required this.description,
  });

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      parkName: json['parkName'] ?? '',
      pricePerNight: (json['pricePerNight'] ?? 0).toDouble(),
      distanceFromGate: (json['distanceFromGate'] ?? 0).toDouble(),
      travelTime: json['travelTime'] ?? '',
      fuelStops: json['fuelStops'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      isEcoFriendly: json['isEcoFriendly'] ?? false,
      isFamilyFriendly: json['isFamilyFriendly'] ?? false,
      hasJeepHire: json['hasJeepHire'] ?? false,
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      description: json['description'] ?? '',
    );
  }
}
