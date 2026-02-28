import 'package:flutter/material.dart';

class AnimalSearchBar extends StatelessWidget {
  final String? selectedAnimal;
  final List<String> animalTypes;
  final ValueChanged<String?> onAnimalChanged;
  final VoidCallback onSearchPressed;

  const AnimalSearchBar({
    Key? key,
    required this.selectedAnimal,
    required this.animalTypes,
    required this.onAnimalChanged,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Search by Animal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _AnimalDropdown(
            selectedAnimal: selectedAnimal,
            animalTypes: animalTypes,
            onChanged: onAnimalChanged,
          ),
          const SizedBox(height: 16),
          _ViewParksButton(onPressed: onSearchPressed),
        ],
      ),
    );
  }
}
