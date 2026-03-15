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