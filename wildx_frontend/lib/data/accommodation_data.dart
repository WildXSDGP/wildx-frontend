import '../models/accommodation.dart';

final List<Accommodation> dummyAccommodations = [
  Accommodation(
    id: 'acc_001',
    name: 'Green Valley Eco-Lodge',
    parkName: 'Yala National Park',
    pricePerNight: 9500,
    distanceFromGate: 4.0,
    rating: 4.9,
    isEcoFriendly: true,
    isFamilyFriendly: true,
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    description:
        'A serene eco-lodge nestled in the heart of Yala, offering sustainable luxury with panoramic views of the surrounding wilderness.',
  ),
  Accommodation(
    id: 'acc_002',
    name: 'Yala Safari Lodge',
    parkName: 'Yala National Park',
    pricePerNight: 8500,
    distanceFromGate: 2.5,
    rating: 4.7,
    isEcoFriendly: true,
    isFamilyFriendly: false,
    imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
    description:
        'An intimate safari camp just minutes from the main gate, perfect for early morning game drives and spotting leopards.',
  ),
  Accommodation(
    id: 'acc_003',
    name: 'Wilpattu Forest Camp',
    parkName: 'Wilpattu National Park',
    pricePerNight: 6200,
    distanceFromGate: 1.2,
    rating: 4.5,
    isEcoFriendly: false,
    isFamilyFriendly: false,
    imageUrl: 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800',
    description:
        'A rustic tented camp on the edge of Wilpattu, offering an authentic bush experience among ancient forest lakes.',
  ),
  Accommodation(
    id: 'acc_004',
    name: 'Udawalawe Family Resort',
    parkName: 'Udawalawe National Park',
    pricePerNight: 12000,
    distanceFromGate: 7.8,
    rating: 4.6,
    isEcoFriendly: false,
    isFamilyFriendly: true,
    imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
    description:
        'A spacious family resort near Udawalawe, renowned for elephant sightings and child-friendly amenities.',
  ),
];

