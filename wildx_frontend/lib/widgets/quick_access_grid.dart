import 'package:flutter/material.dart';
import '../models/quick_access_item.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';

class QuickAccessGrid extends StatelessWidget {
  final List<QuickAccessItem> items;
  final void Function(QuickAccessItem item) onItemTap;

  const QuickAccessGrid({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => QuickAccessCard(
        item: items[i],
        onTap: () => onItemTap(items[i]),
      ),
    );
  }
}
/// Exported so it can be used standalone if needed.
class QuickAccessCard extends StatefulWidget {
  final QuickAccessItem item;
  final VoidCallback onTap;

  const QuickAccessCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<QuickAccessCard> createState() => _QuickAccessCardState();
}

class _QuickAccessCardState extends State<QuickAccessCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (_, child) =>
            Transform.scale(scale: _scaleAnim.value, child: child),
        child: Container(
          decoration: AppDecorations.card,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _IconBox(item: widget.item),
              const SizedBox(height: 8),
              Text(widget.item.label, style: AppTextStyles.label),
            ],
          ),
        ),
      ),
    );
  }
}