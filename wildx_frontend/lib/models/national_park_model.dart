class NationalPark {
  final int id;
  final String name;
  final String description;
  final String location;
  final double sizeInHectares;
  final String openingTime;
  final String closingTime;
  final double entryFee;
  final String imageUrl;
  final String contactNumber;
  final String email;
  final String bestVisitingSeason;
  final bool isActive;
  final List<String> animalTypes;
  final List<String> rulesAndRegulations;

  NationalPark({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.sizeInHectares,
    required this.openingTime,
    required this.closingTime,
    required this.entryFee,
    required this.imageUrl,
    required this.contactNumber,
    required this.email,
    required this.bestVisitingSeason,
    required this.isActive,
    required this.animalTypes,
    required this.rulesAndRegulations,
  });

  factory NationalPark.fromJson(Map<String, dynamic> json) {
    return NationalPark(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      sizeInHectares: (json['sizeInHectares'] ?? 0).toDouble(),
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
      entryFee: (json['entryFee'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      email: json['email'] ?? '',
      bestVisitingSeason: json['bestVisitingSeason'] ?? '',
      isActive: json['isActive'] ?? true,
      animalTypes: List<String>.from(json['animalTypes'] ?? []),
      rulesAndRegulations: List<String>.from(json['rulesAndRegulations'] ?? []),
    );
  }
}
