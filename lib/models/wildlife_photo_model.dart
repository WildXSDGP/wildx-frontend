class WildlifePhoto {
  final String id;
  final String imageUrl;
  final String species;
  final String park;
  final DateTime takenAt;
  final bool isOfflineAvailable;

  const WildlifePhoto({
    required this.id,
    required this.imageUrl,
    required this.species,
    required this.park,
    required this.takenAt,
    this.isOfflineAvailable = false,
  });
}