import 'package:flutter/material.dart';

class WildXColors {
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF1B5E20);
  static const Color accent = Color(0xFFFF8F00);
  static const Color background = Color(0xFFF5F7F5);
  static const Color surface = Colors.white;
  static const Color cardShadow = Color(0x1A000000);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color xpBar = Color(0xFF4CAF50);
  static const Color xpBarBg = Color(0xFFE8F5E9);
  static const Color lockedBadge = Color(0xFFBDBDBD);
}

class BadgeItem {
  final String title;
  final IconData icon;
  final Color color;
  final bool isUnlocked;

  const BadgeItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.isUnlocked,
  });
}

class UserProfile {
  final String name;
  final String memberSince;
  final int sightings;
  final int parks;
  final int photos;
  final int currentXP;
  final int maxXP;
  final String level;
  final List<BadgeItem> badges;

  const UserProfile({
    required this.name,
    required this.memberSince,
    required this.sightings,
    required this.parks,
    required this.photos,
    required this.currentXP,
    required this.maxXP,
    required this.level,
    required this.badges,
  });
}

final UserProfile sampleUser = UserProfile(
  name: 'Safari Explorer',
  memberSince: 'Nov 2024',
  sightings: 28,
  parks: 7,
  photos: 142,
  currentXP: 450,
  maxXP: 1000,
  level: 'Ranger',
  badges: const [
    BadgeItem(
      title: 'First\nSighting',
      icon: Icons.gps_fixed,
      color: Color(0xFFE53935),
      isUnlocked: true,
    ),
    BadgeItem(
      title: '10\nSightings',
      icon: Icons.emoji_events,
      color: Color(0xFFFFC107),
      isUnlocked: true,
    ),
    BadgeItem(
      title: 'Photo\nMaster',
      icon: Icons.camera_alt,
      color: Color(0xFF1565C0),
      isUnlocked: true,
    ),
    BadgeItem(
      title: '5 Parks\nVisited',
      icon: Icons.map,
      color: Color(0xFF2E7D32),
      isUnlocked: true,
    ),
    BadgeItem(
      title: 'Night\nSafari',
      icon: Icons.nightlight_round,
      color: Color(0xFF5C6BC0),
      isUnlocked: false,
    ),
    BadgeItem(
      title: 'Leopard\nSpotter',
      icon: Icons.pets,
      color: Color(0xFFFF8F00),
      isUnlocked: false,
    ),
  ],
);
   // User Profile Screen UI
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _xpController;
  late Animation<double> _xpAnimation;
  final UserProfile user = sampleUser;

  @override
  void initState() {
    super.initState();
    _xpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _xpAnimation = CurvedAnimation(
      parent: _xpController,
      curve: Curves.easeOutCubic,
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _xpController.forward();
    });
  }

  @override
  void dispose() {
    _xpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WildXColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildStatsRow(),
                  const SizedBox(height: 16),
                  _buildXPCard(),
                  const SizedBox(height: 16),
                  _buildBadgesSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: WildXColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.maybePop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [WildXColors.primaryDark, WildXColors.primary],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white70,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: WildXColors.accent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 13,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Member since ${user.memberSince}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard(
          icon: '🐘',
          value: user.sightings.toString(),
          label: 'Sightings',
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          icon: '🏞',
          value: user.parks.toString(),
          label: 'Parks',
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          icon: '📷',
          value: user.photos.toString(),
          label: 'Photos',
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: WildXColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: WildXColors.cardShadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: WildXColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: WildXColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildXPCard() {
    final double progress = user.currentXP / user.maxXP;
    final levels = ['Explorer', 'Ranger', 'Guardian'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WildXColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: WildXColors.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.military_tech_rounded,
                    color: WildXColors.accent,
                    size: 22,
                  ),
                  const SizedBox(width: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 15),
                      children: [
                        const TextSpan(
                          text: 'Level: ',
                          style: TextStyle(
                            color: WildXColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: user.level,
                          style: const TextStyle(
                            color: WildXColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                '${user.currentXP} / ${user.maxXP} XP',
                style: const TextStyle(
                  color: WildXColors.primaryLight,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedBuilder(
              animation: _xpAnimation,
              builder: (context, _) {
                return LinearProgressIndicator(
                  value: progress * _xpAnimation.value,
                  minHeight: 10,
                  backgroundColor: WildXColors.xpBarBg,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    WildXColors.xpBar,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: levels.map((lvl) {
              final bool isActive = lvl == user.level;
              return Text(
                lvl,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive
                      ? WildXColors.primary
                      : WildXColors.textSecondary,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.workspace_premium_outlined,
              color: WildXColors.textPrimary,
              size: 20,
            ),
            SizedBox(width: 6),
            Text(
              'Badges & Achievements',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: WildXColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemCount: user.badges.length,
          itemBuilder: (context, index) {
            return _BadgeCard(badge: user.badges[index]);
          },
        ),
      ],
    );
  }
}
  // Badge Grid and XP Bar
class _BadgeCard extends StatefulWidget {
  final BadgeItem badge;
  const _BadgeCard({required this.badge});

  @override
  State<_BadgeCard> createState() => _BadgeCardState();
}

class _BadgeCardState extends State<_BadgeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final badge = widget.badge;
    final bool locked = !badge.isUnlocked;

    return GestureDetector(
      onTapDown: locked ? null : (_) => _scaleController.forward(),
      onTapUp: locked ? null : (_) => _scaleController.reverse(),
      onTapCancel: locked ? null : () => _scaleController.reverse(),
      onTap: locked
          ? null
          : () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${badge.title.replaceAll('\n', ' ')} – Unlocked!',
                  ),
                  duration: const Duration(seconds: 1),
                  backgroundColor: WildXColors.primary,
                ),
              );
            },
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) =>
            Transform.scale(scale: _scaleAnim.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: locked ? const Color(0xFFF5F5F5) : WildXColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: locked
                  ? const Color(0xFFE0E0E0)
                  : badge.color.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: locked
                ? null
                : [
                    BoxShadow(
                      color: badge.color.withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: locked
                      ? const Color(0xFFEEEEEE)
                      : badge.color.withOpacity(0.12),
                ),
                child: locked
                    ? const Icon(
                        Icons.lock_outline,
                        size: 24,
                        color: WildXColors.lockedBadge,
                      )
                    : Icon(badge.icon, size: 26, color: badge.color),
              ),
              const SizedBox(height: 8),
              Text(
                badge.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: locked
                      ? WildXColors.lockedBadge
                      : WildXColors.textPrimary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}