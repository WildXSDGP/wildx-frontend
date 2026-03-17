import '../models/user_model.dart';

final kSampleUser = UserModel(
  name: 'Safari Explorer',
  profileImageUrl: null, 
  memberSince: DateTime(2024, 11, 1),
  sightingsCount: 28,
  parksVisited: 7,
  photosCount: 142,
  xp: 450,
  currentLevel: WildXLevel.ranger,

  topParks: const [
    ParkVisit(parkName: 'Yala National Park', visitCount: 12),
    ParkVisit(parkName: 'Udawalawe',           visitCount: 8),
    ParkVisit(parkName: 'Wilpattu',            visitCount: 5),
  ],
  
  
  badges: const [], 
);