import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/national_park_model.dart';

class ParkMapScreen extends StatefulWidget {
  final NationalPark park;

  const ParkMapScreen({Key? key, required this.park}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _ParkMapScreenState extends State<ParkMapScreen> {
  late GoogleMapController _mapController;

  // create real cordination of the  national parks.
  LatLng get _parkCenter {
    switch (widget.park.name) {
      case 'Yala National Park':
        return const LatLng(6.3724, 81.5185);
      case 'Udawalawe National Park':
        return const LatLng(6.4825, 80.8986);
      case 'Wilpattu National Park':
        return const LatLng(8.4878, 80.0252);
      default:
        return const LatLng(7.8731, 80.7718); // Center of Sri Lanka
    }
  }

  double get _zoomLevel {
    // Larger parks need less zoom to fit on screen
    switch (widget.park.name) {
      case 'Yala National Park':
        return 11.5;
      case 'Udawalawe National Park':
        return 12.0;
      case 'Wilpattu National Park':
        return 11.0;
      default:
        return 12.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
