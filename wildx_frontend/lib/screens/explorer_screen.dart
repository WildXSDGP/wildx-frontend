import 'package:flutter/material.dart';

import '../models/ranger_model.dart';
import '../theme/safari_theme.dart';
import '../widgets/ranger_header.dart';
import '../widgets/tracker_card.dart';
import '../widgets/level_card.dart';
import '../widgets/badge_grid.dart';
import '../widgets/safari_parks_card.dart';

class ExplorerScreen extends StatefulWidget {
  final RangerModel ranger;

  const ExplorerScreen({super.key, required this.ranger});

  @override
  State<ExplorerScreen> createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _xpAnim;
  late RangerModel _ranger;

  @override
  void initState() {
    super.initState();
    _ranger = widget.ranger;
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

  void _onRangerUpdated(RangerModel updated) {
    setState(() => _ranger = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SafariTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: RangerHeader(
              ranger: _ranger,
              onRangerUpdated: _onRangerUpdated,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),

                // Bio card
                if (_ranger.bio != null && _ranger.bio!.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: SafariTheme.cardDecoration,
                    child: Text(
                      _ranger.bio!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: SafariTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                TrackerCardRow(ranger: _ranger),
                const SizedBox(height: 20),

                LevelCard(ranger: _ranger, animation: _xpAnim),
                const SizedBox(height: 20),

                BadgeGrid(badges: _ranger.badges),
                const SizedBox(height: 20),

                SafariParksCard(parks: _ranger.topParks),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
