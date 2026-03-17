import 'package:flutter/material.dart';
import 'app_colors.dart';

/// WildX — Centralized text styles
abstract class AppTextStyles {
  static const TextStyle appTitle = TextStyle(
    color: Colors.white,
    fontSize: 26,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
  );

  static const TextStyle appSubtitle = TextStyle(
    color: Colors.white70,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 12,
    color: AppColors.textHint,
  );

  static const TextStyle statValue = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle statLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
  );

  static const TextStyle badge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle actionLink = TextStyle(
    color: AppColors.primary,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
}
