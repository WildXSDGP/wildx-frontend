class Sighting {
  final String id;
  final String animalName;
  final String parkName;
  final DateTime date;
  final String imageUrl;
  final String category;

  const Sighting({
    required this.id,
    required this.animalName,
    required this.parkName,
    required this.date,
    required this.imageUrl,
    required this.category,
  });

  String get formattedDate =>
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.year}';

  @override
  String toString() => 'Sighting($animalName @ $parkName)';
}
