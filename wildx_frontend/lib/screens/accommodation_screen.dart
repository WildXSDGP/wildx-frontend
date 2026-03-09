import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../data/accommodation_data.dart';
import '../models/accommodation.dart';
import '../widgets/accommodation_card.dart';
import '../widgets/bar_button.dart';


class AccommodationScreen extends StatefulWidget {
  const AccommodationScreen({super.key});

  @override
  State<AccommodationScreen> createState() => _AccommodationScreenState();
}

class _AccommodationScreenState extends State<AccommodationScreen> {
  SortOption _selectedSort = SortOption.topRated;

  double _maxPrice = 15000;
  double _maxDistance = 20;
  bool _ecoOnly = false;
  bool _familyOnly = false;

  List<Accommodation> get _filtered {
    var list = dummyAccommodations.where((a) {
      if (a.pricePerNight > _maxPrice) return false;
      if (a.distanceKm > _maxDistance) return false;
      if (_ecoOnly && !a.isEco) return false;
      if (_familyOnly && !a.isFamily) return false;
      return true;
    }).toList();

    switch (_selectedSort) {
      case SortOption.topRated:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.closest:
        list.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        break;
      case SortOption.budget:
        list.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
        break;
      case SortOption.familyFriendly:
        list.sort((a, b) => (b.isFamily ? 1 : 0).compareTo(a.isFamily ? 1 : 0));
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenSoft,
      body: Column(
        children: [
          _buildHeader(context),
          _buildFilterSortBar(),
          _buildSortTabs(),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Text('No accommodations found',
                        style: TextStyle(color: kGreen)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) =>
                        AccommodationCard(item: _filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }

  // ── Green gradient header ──────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kGreen, kGreenLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 20,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white24,
              child: Icon(Icons.arrow_back_ios_new,
                  size: 14, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Accommodation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Find your perfect stay near the parks',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Filter + Sort bar ──────────────────────
  Widget _buildFilterSortBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          BarButton(icon: Icons.tune, label: 'Filters', onTap: _showFilterSheet),
          const SizedBox(width: 12),
          BarButton(icon: Icons.sort, label: 'Sort', onTap: _showSortSheet),
        ],
      ),
    );
  }

  // ── Sort tabs ──────────────────────────────
  Widget _buildSortTabs() {
    final tabs = [
      (SortOption.topRated, 'Top Rated'),
      (SortOption.closest, 'Closest'),
      (SortOption.budget, 'Budget'),
    ];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Row(
        children: tabs.map((t) {
          final selected = _selectedSort == t.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedSort = t.$1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? kGreen : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  t.$2,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.grey.shade700,
                    fontWeight:
                        selected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Filter bottom sheet ────────────────────
  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModal) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filters',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kGreen)),
              const SizedBox(height: 16),
              Text('Max Price: LKR ${_maxPrice.toInt()}',
                  style: const TextStyle(color: kGreen)),
              Slider(
                value: _maxPrice,
                min: 3000,
                max: 20000,
                divisions: 17,
                activeColor: kGreen,
                onChanged: (v) => setModal(() => _maxPrice = v),
              ),
              Text('Max Distance: ${_maxDistance.toInt()} km',
                  style: const TextStyle(color: kGreen)),
              Slider(
                value: _maxDistance,
                min: 1,
                max: 30,
                divisions: 29,
                activeColor: kGreen,
                onChanged: (v) => setModal(() => _maxDistance = v),
              ),
              SwitchListTile(
                title: const Text('Eco-Friendly Only'),
                value: _ecoOnly,
                activeColor: kGreen,
                onChanged: (v) => setModal(() => _ecoOnly = v),
              ),
              SwitchListTile(
                title: const Text('Family Friendly Only'),
                value: _familyOnly,
                activeColor: kGreen,
                onChanged: (v) => setModal(() => _familyOnly = v),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(ctx);
                  },
                  child: const Text('Apply Filters',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Sort bottom sheet ──────────────────────
  void _showSortSheet() {
    final options = [
      (SortOption.topRated, Icons.star, 'Top Rated'),
      (SortOption.closest, Icons.near_me, 'Closest'),
      (SortOption.budget, Icons.attach_money, 'Budget Friendly'),
      (SortOption.familyFriendly, Icons.family_restroom, 'Family Friendly'),
    ];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sort By',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kGreen)),
            const SizedBox(height: 12),
            ...options.map((o) => ListTile(
                  leading: Icon(o.$2,
                      color: _selectedSort == o.$1 ? kGreen : Colors.grey),
                  title: Text(o.$3),
                  trailing: _selectedSort == o.$1
                      ? const Icon(Icons.check, color: kGreen)
                      : null,
                  onTap: () {
                    setState(() => _selectedSort = o.$1);
                    Navigator.pop(ctx);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
