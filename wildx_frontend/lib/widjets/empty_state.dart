import 'package:flutter/material.dart';

class EmptySearchState extends StatelessWidget {
  const EmptySearchState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Select an animal and click "View Parks"',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ResultNotFoundState extends StatelessWidget {
  final String animalName;

  const ResultNotFoundState({Key? key, required this.animalName})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
