import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────

class WildlifePhoto {
  final String id;
  final String imageUrl;
  final String species;
  final String park;
  final DateTime takenAt;
  final bool isOfflineAvailable;

  const WildlifePhoto({
    required this.id,
    required this.imageUrl,
    required this.species,
    required this.park,
    required this.takenAt,
    this.isOfflineAvailable = false,
  });
}

// ─────────────────────────────────────────────
//  MOCK DATA
// ─────────────────────────────────────────────

final List<String> kParks = [
  'All Parks',
  'Yala National Park',
  'Udawalawe',
  'Wilpattu',
  'Minneriya',
];

final List<Map<String, dynamic>> kSpecies = [
  {'label': 'All', 'color': Color(0xFFFF6B35), 'icon': Icons.pets},
  {'label': 'Elephant', 'color': Color(0xFF4CAF50), 'icon': Icons.sentiment_very_satisfied},
  {'label': 'Leopard', 'color': Color(0xFF9C27B0), 'icon': Icons.catching_pokemon},
  {'label': 'Bird', 'color': Color(0xFF2196F3), 'icon': Icons.flutter_dash},
  {'label': 'Crocodile', 'color': Color(0xFF009688), 'icon': Icons.water},
  {'label': 'Deer', 'color': Color(0xFFFF9800), 'icon': Icons.nature},
];

final List<WildlifePhoto> kPhotos = [
  WildlifePhoto(
    id: '1',
    imageUrl: 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=400',
    species: 'Leopard',
    park: 'Yala National Park',
    takenAt: DateTime(2024, 3, 10, 7, 30),
    isOfflineAvailable: true,
  ),
  WildlifePhoto(
    id: '2',
    imageUrl: 'https://images.unsplash.com/photo-1564760055775-d63b17a55c44?w=400',
    species: 'Elephant',
    park: 'Yala National Park',
    takenAt: DateTime(2024, 3, 10, 8, 15),
    isOfflineAvailable: true,
  ),
  WildlifePhoto(
    id: '3',
    imageUrl: 'https://images.unsplash.com/photo-1549366021-9f761d450615?w=400',
    species: 'Elephant',
    park: 'Udawalawe',
    takenAt: DateTime(2024, 3, 9, 6, 45),
  ),
  WildlifePhoto(
    id: '4',
    imageUrl: 'https://images.unsplash.com/photo-1488826668888-363013788e5c?w=400',
    species: 'Bird',
    park: 'Yala National Park',
    takenAt: DateTime(2024, 3, 9, 9, 00),
  ),
  WildlifePhoto(
    id: '5',
    imageUrl: 'https://images.unsplash.com/photo-1551085254-e96b210db58a?w=400',
    species: 'Elephant',
    park: 'Minneriya',
    takenAt: DateTime(2024, 3, 8, 17, 30),
    isOfflineAvailable: true,
  ),
  WildlifePhoto(
    id: '6',
    imageUrl: 'https://images.unsplash.com/photo-1504173010664-32509107de52?w=400',
    species: 'Bird',
    park: 'Wilpattu',
    takenAt: DateTime(2024, 3, 8, 16, 00),
  ),
  WildlifePhoto(
    id: '7',
    imageUrl: 'https://images.unsplash.com/photo-1474511320723-9a56873867b5?w=400',
    species: 'Deer',
    park: 'Yala National Park',
    takenAt: DateTime(2024, 3, 7, 6, 30),
  ),
  WildlifePhoto(
    id: '8',
    imageUrl: 'https://images.unsplash.com/photo-1509909756405-be0199881695?w=400',
    species: 'Crocodile',
    park: 'Yala National Park',
    takenAt: DateTime(2024, 3, 7, 10, 45),
    isOfflineAvailable: true,
  ),
  WildlifePhoto(
    id: '9',
    imageUrl: 'https://images.unsplash.com/photo-1551085254-e96b210db58a?w=400',
    species: 'Elephant',
    park: 'Udawalawe',
    takenAt: DateTime(2024, 3, 6, 8, 00),
  ),
  WildlifePhoto(
    id: '10',
    imageUrl: 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=400',
    species: 'Leopard',
    park: 'Wilpattu',
    takenAt: DateTime(2024, 3, 6, 7, 15),
    isOfflineAvailable: true,
  ),
];

// ─────────────────────────────────────────────
//  COLOR PALETTE
// ─────────────────────────────────────────────

class WildXColors {
  static const primary = Color(0xFF2E7D32);      // Deep Forest Green
  static const primaryLight = Color(0xFF4CAF50);
  static const accent = Color(0xFFFF6B35);        // Safari Orange
  static const surface = Color(0xFFF8F5F0);       // Warm Ivory
  static const cardBg = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B7280);
  static const divider = Color(0xFFE8E0D8);
  static const chipSelected = Color(0xFF2E7D32);
  static const chipUnselected = Color(0xFFFFFFFF);
  static const shareBtn = Color(0xFF2E7D32);
}

// ─────────────────────────────────────────────
//  MAIN ENTRY (for standalone testing)
// ─────────────────────────────────────────────

void main() {
  runApp(const WildXApp());
}

class WildXApp extends StatelessWidget {
  const WildXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildX – Wildlife Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSeed(
          seedColor: WildXColors.primary,
          background: WildXColors.surface,
        ),
        scaffoldBackgroundColor: WildXColors.surface,
        useMaterial3: true,
      ),
      home: const WildlifeGalleryPage(),
    );
  }
}

// ─────────────────────────────────────────────
//  WILDLIFE GALLERY PAGE
// ─────────────────────────────────────────────

class WildlifeGalleryPage extends StatefulWidget {
  const WildlifeGalleryPage({super.key});

  @override
  State<WildlifeGalleryPage> createState() => _WildlifeGalleryPageState();
}

class _WildlifeGalleryPageState extends State<WildlifeGalleryPage>
    with TickerProviderStateMixin {
  String _selectedPark = 'All Parks';
  String _selectedSpecies = 'All';
  late AnimationController _fabAnimController;
  late Animation<double> _fabScaleAnim;

  @override
  void initState() {
    super.initState();
    _fabAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fabScaleAnim = CurvedAnimation(
      parent: _fabAnimController,
      curve: Curves.elasticOut,
    );
    _fabAnimController.forward();
  }

  @override
  void dispose() {
    _fabAnimController.dispose();
    super.dispose();
  }

  List<WildlifePhoto> get filteredPhotos {
    return kPhotos.where((photo) {
      final parkMatch =
          _selectedPark == 'All Parks' || photo.park == _selectedPark;
      final speciesMatch =
          _selectedSpecies == 'All' || photo.species == _selectedSpecies;
      return parkMatch && speciesMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final photos = filteredPhotos;

    return Scaffold(
      backgroundColor: WildXColors.surface,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // ── App Bar ──
              _buildSliverAppBar(),

              // ── Park Filter ──
              SliverToBoxAdapter(child: _buildParkFilter()),

              // ── Species Filter ──
              SliverToBoxAdapter(child: _buildSpeciesFilter()),

              // ── Empty state or Grid ──
              if (photos.isEmpty)
                SliverFillRemaining(child: _buildEmptyState())
              else
                _buildPhotoGrid(photos),

              // Bottom padding so FAB doesn't overlap last row
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // ── Share Your Photo FAB ──
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: _buildShareFab(),
          ),
        ],
      ),
    );
  }

  // ── App Bar ────────────────────────────────

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: WildXColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      expandedHeight: 100,
      leading: IconButton(
        icon: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: WildXColors.cardBg,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: WildXColors.textPrimary,
          ),
        ),
        onPressed: () => Navigator.maybePop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 72, bottom: 16),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wildlife Gallery',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: WildXColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              '${kPhotos.length} photos',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: WildXColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: WildXColors.cardBg,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.search_rounded,
              size: 18,
              color: WildXColors.textPrimary,
            ),
          ),
          onPressed: () {
            // TODO: Implement search
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ── Park Filter ────────────────────────────

  Widget _buildParkFilter() {
    return Container(
      color: WildXColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.grid_view_rounded,
                size: 14,
                color: WildXColors.textSecondary,
              ),
              const SizedBox(width: 6),
              const Text(
                'Filter by Park',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: WildXColors.textSecondary,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: kParks.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final park = kParks[index];
                final isSelected = park == _selectedPark;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPark = park),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? WildXColors.primary
                          : WildXColors.chipUnselected,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? WildXColors.primary
                            : WildXColors.divider,
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: WildXColors.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      park,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : WildXColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: WildXColors.divider,
          ),
        ],
      ),
    );
  }

  // ── Species Filter ─────────────────────────

  Widget _buildSpeciesFilter() {
    return Container(
      color: WildXColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
      child: SizedBox(
        height: 38,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: kSpecies.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final species = kSpecies[index];
            final label = species['label'] as String;
            final color = species['color'] as Color;
            final isSelected = label == _selectedSpecies;

            return GestureDetector(
              onTap: () => setState(() => _selectedSpecies = label),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isSelected ? color : WildXColors.chipUnselected,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? color : WildXColors.divider,
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : WildXColors.textPrimary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Photo Grid ─────────────────────────────

  Widget _buildPhotoGrid(List<WildlifePhoto> photos) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildPhotoCard(photos[index], index),
          childCount: photos.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
      ),
    );
  }

  Widget _buildPhotoCard(WildlifePhoto photo, int index) {
    // Species chip color
    final speciesData = kSpecies.firstWhere(
      (s) => s['label'] == photo.species,
      orElse: () => kSpecies.first,
    );
    final chipColor = speciesData['color'] as Color;

    return GestureDetector(
      onTap: () => _openPhotoViewer(photo),
      child: Hero(
        tag: 'photo_${photo.id}',
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300 + index * 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Photo
                Image.network(
                  photo.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: WildXColors.divider,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                          color: WildXColors.primary,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    color: WildXColors.divider,
                    child: const Icon(
                      Icons.broken_image_rounded,
                      color: WildXColors.textSecondary,
                      size: 36,
                    ),
                  ),
                ),

                // Gradient overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.55),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ),

                // Species badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: chipColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      photo.species,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),

                // Offline indicator
                if (photo.isOfflineAvailable)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.download_done_rounded,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),

                // Park name at bottom
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Text(
                    photo.park,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Empty State ────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: WildXColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No photos found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: WildXColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try changing your filters',
            style: TextStyle(
              fontSize: 14,
              color: WildXColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ── Share FAB ─────────────────────────────

  Widget _buildShareFab() {
    return Center(
      child: ScaleTransition(
        scale: _fabScaleAnim,
        child: GestureDetector(
          onTap: _openShareSheet,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            decoration: BoxDecoration(
              color: WildXColors.shareBtn,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: WildXColors.primary.withOpacity(0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add_photo_alternate_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Share Your Photo',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  //  ACTIONS
  // ─────────────────────────────────────────

  void _openPhotoViewer(WildlifePhoto photo) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: _PhotoViewerPage(photo: photo),
        ),
      ),
    );
  }

  void _openShareSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _SharePhotoSheet(),
    );
  }
}

// ─────────────────────────────────────────────
//  PHOTO VIEWER PAGE
// ─────────────────────────────────────────────

class _PhotoViewerPage extends StatelessWidget {
  final WildlifePhoto photo;

  const _PhotoViewerPage({required this.photo});

  @override
  Widget build(BuildContext context) {
    final speciesData = kSpecies.firstWhere(
      (s) => s['label'] == photo.species,
      orElse: () => kSpecies.first,
    );
    final chipColor = speciesData['color'] as Color;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full screen image
          Hero(
            tag: 'photo_${photo.id}',
            child: Image.network(
              photo.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.broken_image_rounded,
                color: Colors.white54,
                size: 64,
              ),
            ),
          ),

          // Top gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 120,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Bottom gradient & info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.85),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: chipColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        photo.species,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      photo.park,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatDate(photo.takenAt)}  •  ${_formatTime(photo.takenAt)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _actionButton(
                          icon: Icons.download_rounded,
                          label: 'Save',
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _actionButton(
                          icon: Icons.share_rounded,
                          label: 'Share',
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _actionButton(
                          icon: Icons.edit_rounded,
                          label: 'Tag',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Back button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) =>
      '${dt.day} ${_monthName(dt.month)} ${dt.year}';

  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  String _monthName(int m) => const [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ][m];
}

// ─────────────────────────────────────────────
//  SHARE PHOTO BOTTOM SHEET
// ─────────────────────────────────────────────

class _SharePhotoSheet extends StatefulWidget {
  const _SharePhotoSheet();

  @override
  State<_SharePhotoSheet> createState() => _SharePhotoSheetState();
}

class _SharePhotoSheetState extends State<_SharePhotoSheet> {
  String? _selectedSpeciesTag;
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: WildXColors.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: WildXColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const Text(
            'Share Your Photo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: WildXColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Help other safari visitors spot wildlife',
            style: TextStyle(
              fontSize: 13,
              color: WildXColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Upload area
          GestureDetector(
            onTap: () {
              // TODO: Implement image picker
            },
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: WildXColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: WildXColors.primary.withOpacity(0.3),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 40,
                      color: WildXColors.primary,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap to choose photo',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: WildXColors.primary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'GPS location will be attached automatically',
                      style: TextStyle(
                        fontSize: 11,
                        color: WildXColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Species tag
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Tag Species',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: WildXColors.textPrimary.withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: kSpecies.skip(1).map((species) {
              final label = species['label'] as String;
              final color = species['color'] as Color;
              final isSelected = _selectedSpeciesTag == label;
              return GestureDetector(
                onTap: () => setState(() => _selectedSpeciesTag = label),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? color : WildXColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? color : WildXColors.divider,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : WildXColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Upload button
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: _uploading ? null : _upload,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _uploading
                      ? WildXColors.primary.withOpacity(0.6)
                      : WildXColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: WildXColors.primary.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: _uploading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Upload & Share',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _upload() async {
    setState(() => _uploading = true);
    // Simulate upload
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Photo shared successfully! 🎉'),
          backgroundColor: WildXColors.primary,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }
}