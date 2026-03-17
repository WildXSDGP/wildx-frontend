class UserStats {
  final int sightings;
  final int badges;
  final int parks;

  const UserStats({
    required this.sightings,
    required this.badges,
    required this.parks,
  });

  @override
  String toString() =>
      'UserStats(sightings: $sightings, badges: $badges, parks: $parks)';
}
