import 'package:flutter/material.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';

class AppTextStyles {
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // HEADINGS
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 42.8,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 34.2,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 27.3,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 21.9,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 17.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // BODY
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textBody,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textBody,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // LABEL / BOUTONS
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );

  static const TextStyle label = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // CAPTION / HINT
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const TextStyle caption = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 11.2,
    fontWeight: FontWeight.w300,
    color: AppColors.textMuted,
  );
}
