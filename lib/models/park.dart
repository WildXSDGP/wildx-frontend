class Park {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final String description;
  final int animalCount;
  final bool isFeatured;

  const Park({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.animalCount,
    this.isFeatured = false,
  });

  @override
  String toString() => 'Park(id: $id, name: $name)';
}
