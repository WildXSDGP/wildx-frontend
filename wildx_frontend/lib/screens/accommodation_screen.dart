import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// GREEN THEME COLORS
// ─────────────────────────────────────────────
const kGreen = Color(0xFF2E7D32);        // dark green - header, buttons
const kGreenLight = Color(0xFF4CAF50);   // medium green - accents
const kGreenSoft = Color(0xFFE8F5E9);    // very light green - background

// ─────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────
class Accommodation {
  final String name;
  final String type;
  final double pricePerNight;
  final double distanceKm;
  final double rating;
  final int reviewCount;
  final bool isEco;
  final bool isFamily;
  final String imageUrl;
  final String parkId;

  const Accommodation({
    required this.name,
    required this.type,
    required this.pricePerNight,
    required this.distanceKm,
    required this.rating,
    required this.reviewCount,
    required this.isEco,
    required this.isFamily,
    required this.imageUrl,
    required this.parkId,
  });
}

// ─────────────────────────────────────────────
// DUMMY DATA
// ─────────────────────────────────────────────
final List<Accommodation> dummyAccommodations = [
  Accommodation(
    name: 'Green Valley Eco-Lodge',
    type: 'Eco-Lodge',
    pricePerNight: 9500,
    distanceKm: 4.0,
    rating: 4.9,
    reviewCount: 312,
    isEco: true,
    isFamily: true,
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    parkId: 'yala',
  ),
  Accommodation(
    name: 'Yala Safari Lodge',
    type: 'Safari Camp',
    pricePerNight: 8500,
    distanceKm: 2.5,
    rating: 4.7,
    reviewCount: 189,
    isEco: true,
    isFamily: false,
    imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
    parkId: 'yala',
  ),
  Accommodation(
    name: 'Wilpattu Forest Camp',
    type: 'Tented Site',
    pricePerNight: 6200,
    distanceKm: 1.2,
    rating: 4.5,
    reviewCount: 94,
    isEco: false,
    isFamily: false,
    imageUrl: 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800',
    parkId: 'wilpattu',
  ),
  Accommodation(
    name: 'Udawalawe Family Resort',
    type: 'Hotel',
    pricePerNight: 12000,
    distanceKm: 7.8,
    rating: 4.6,
    reviewCount: 421,
    isEco: false,
    isFamily: true,
    imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
    parkId: 'udawalawe',
  ),
];

// ─────────────────────────────────────────────
// SORT OPTIONS
// ─────────────────────────────────────────────
enum SortOption { topRated, closest, budget, familyFriendly }

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────
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
                        _AccommodationCard(item: _filtered[index]),
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
          _BarButton(icon: Icons.tune, label: 'Filters', onTap: _showFilterSheet),
          const SizedBox(width: 12),
          _BarButton(icon: Icons.sort, label: 'Sort', onTap: _showSortSheet),
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

// ─────────────────────────────────────────────
// ACCOMMODATION CARD
// ─────────────────────────────────────────────
class _AccommodationCard extends StatelessWidget {
  final Accommodation item;
  const _AccommodationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGreen.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + badges
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  item.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: kGreenSoft,
                    child: const Icon(Icons.image_not_supported,
                        size: 50, color: kGreen),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Row(
                  children: [
                    if (item.isEco) _Badge(label: '🌿 Eco', color: kGreen),
                    if (item.isEco) const SizedBox(width: 6),
                    if (item.isFamily)
                      _Badge(label: '👨‍👩‍👧 Family', color: kGreenLight),
                  ],
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'LKR ${item.pricePerNight.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: kGreen,
                          ),
                        ),
                        const Text('per night',
                            style:
                                TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.type,
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: kGreenLight),
                    Text(
                      '  ${item.distanceKm} km from park',
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    Text(
                      ' ${item.rating} (${item.reviewCount})',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      // TODO: Navigate to AccommodationDetailScreen
                    },
                    child: const Text('View Details',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HELPER WIDGETS
// ─────────────────────────────────────────────
class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }
}

class _BarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _BarButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: kGreenLight.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: kGreen),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: kGreen)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ENTRY POINT
// ─────────────────────────────────────────────
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AccommodationScreen(),
  ));
}