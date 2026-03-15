import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../theme/wildx_theme.dart';
import '../widgets/profile_header.dart';
import '../widgets/stat_card.dart';
import '../widgets/xp_progress_card.dart';
import '../widgets/achievement_grid.dart';
import '../widgets/top_parks_card.dart';

class ProfileScreen extends StatefulWidget {
  /// Pass any [UserModel] — screen is fully dynamic.
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _xpAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _xpAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WildXTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          
        ],
      ),
    );
  }
}