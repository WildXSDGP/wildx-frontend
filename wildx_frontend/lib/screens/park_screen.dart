import 'package:flutter/material.dart';
import '../data/national_park_data.dart';
import '../models/national_park_model.dart';
import '../services/national_park_service.dart';
import '../widgets/animal_search_bar.dart';
import '../widgets/empty_state.dart';
import '../widgets/park_card.dart';

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
      final parks = await _parkService.searchParkByAnimal(_selectedAnimal!);
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

  Widget _buildResults() {
    if (!_hasSearched) return const EmptySearchState();

    // Loading parks
    if (_loadingParks) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error loading parks
    if (_parkLoadError != null) {
      return _ErrorState(message: _parkLoadError!, onRetry: _searchParks);
    }

    // No results
    if (_parks.isEmpty) {
      return ResultNotFoundState(animalName: _selectedAnimal!);
    }

    // Results list
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _parks.length,
      itemBuilder: (context, index) => ParkCard(park: _parks[index]),
    );
  }

  Widget _buildSearchBar() {
    return AnimalSearchBar(
      selectedAnimal: _selectedAnimal,
      animalTypes: _animalTypes,
      onAnimalChanged: _onAnimalChanged,
      onSearchPressed: _searchParks,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find National Parks'),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildResults()),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
