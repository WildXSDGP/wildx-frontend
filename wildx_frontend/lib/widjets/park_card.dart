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

class _ParkImage extends StatelessWidget {
  final String imageUrl;

  const _ParkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Image.network(
        imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.park, size: 64, color: Colors.grey),
          );
        },
      ),
    );
  }
}

class _ParkInfo extends StatelessWidget {
  final NationalPark park;

  const _ParkInfo({required this.park});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            park.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _IconRow(icon: Icons.location_on, text: park.location),
          const SizedBox(height: 8),
          _IconRow(
            icon: Icons.access_time,
            text: '${park.openingTime} - ${park.closingTime}',
          ),
          const SizedBox(height: 8),
          _IconRow(
            icon: Icons.monetization_on,
            text: 'LKR ${park.entryFee.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }
}

class _IconRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
      ],
    );
  }
}
