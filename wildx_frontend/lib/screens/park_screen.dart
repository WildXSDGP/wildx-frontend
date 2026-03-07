import 'package:flutter/material.dart';
import '../data/national_park_data.dart';
import '../models/national_park_model.dart';
import '../services/national_park_service.dart';
import '../widjets/animal_search_bar.dart';
import '../widjets/empty_state.dart';
import '../widjets/park_card.dart';

class ParkSearchScreen extends StatefulWidget {
  const ParkSearchScreen({Key? key}) : super(key: key);

  @override
  State<ParkSearchScreen> createState() => _ParkSearchScreenState();
}

class _ParkSearchScreenState extends State<ParkSearchScreen> {
  final NationalParkService _parkService = NationalParkService();

  final List<String> _animalTypes = NationalParkData.animalTypes;

  String? _selectedAnimal;
  bool _hasSearched = false;

  // Parks result state
  List<NationalPark> _parks = [];
  bool _loadingParks = false;
  String? _parkLoadError;

  void _onAnimalChanged(String? value) {
    setState(() {
      _selectedAnimal = value;
      _hasSearched = false;
      _parks = [];
      _parkLoadError = null;
    });
  }

  Future<void> _searchParks() async {
    if (_selectedAnimal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an animal first')),
      );
      return;
    }

    setState(() {
      _loadingParks = true;
      _hasSearched = true;
      _parkLoadError = null;
      _parks = [];
    });

    try {
      final parks = await _parkService.searchParkByAnumal(_selectedAnimal!);
      setState(() {
        _parks = parks;
        _loadingParks = false;
      });
    } catch (e) {
      setState(() {
        _parkLoadError = 'Failed to load parks. Please try again.';
        _loadingParks = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
