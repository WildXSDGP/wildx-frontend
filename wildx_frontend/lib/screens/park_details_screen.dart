import 'package:flutter/material.dart';
import '../models/national_park_model.dart';
import '../widjets/info_card.dart';
import '../widjets/rule_item.dart';

class ParkDetailsScreen extends StatelessWidget {
  final NationalPark park;

  const ParkDetailsScreen({Key? key, required this.park}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _ParkSliverAppBar extends StatelessWidget {
  final NationalPark park;

  const _ParkSliverAppBar({required this.park});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(park.name),
        background: Image.network(
          park.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.park, size: 100),
            );
          },
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class _AnimalChips extends StatelessWidget {
  final List<String> animals;
  const _AnimalChips({required this.animals});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: animals.map((animal) {
        return Chip(label: Text(animal), backgroundColor: Colors.green[100]);
      }).toList(),
    );
  }
}
