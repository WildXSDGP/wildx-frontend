import 'package:flutter/material.dart';
import '../models/national_park_model.dart';

class ParkCard extends StatelessWidget {
  final NationalPark park;

  const ParkCard({Key? key, required this.park}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ParkDetailsScreen(park: park),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ParkImage(imageUrl: park.imageUrl),
            _ParkInfo(park: park),
          ],
        ),
      ),
    );
  }
}
