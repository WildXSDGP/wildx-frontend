import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Row(
              children: [
                Text(actionLabel!, style: AppTextStyles.actionLink),
                const SizedBox(width: 3),
                const Icon(Icons.arrow_forward,
                    size: 14, color: AppColors.primary),
              ],
            ),
          ),
      ],
    );
  }
}
