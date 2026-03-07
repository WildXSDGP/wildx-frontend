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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
