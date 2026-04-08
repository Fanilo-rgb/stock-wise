import 'package:flutter/material.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

enum AppPillVariant { primary, success, warning, danger, neutral }

class AppPill extends StatelessWidget {
  final String label;
  final AppPillVariant variant;
  final IconData? icon;

  const AppPill({
    super.key,
    required this.label,
    this.variant = AppPillVariant.neutral,
    this.icon,
  });

  Color get _backgroundColor => switch (variant) {
    AppPillVariant.primary => AppColors.primary100,
    AppPillVariant.success => AppColors.success100,
    AppPillVariant.warning => AppColors.warning100,
    AppPillVariant.danger => AppColors.danger100,
    AppPillVariant.neutral => AppColors.grey100,
  };

  Color get _foregroundColor => switch (variant) {
    AppPillVariant.primary => AppColors.primary700,
    AppPillVariant.success => AppColors.success700,
    AppPillVariant.warning => AppColors.warning700,
    AppPillVariant.danger => AppColors.danger700,
    AppPillVariant.neutral => AppColors.grey700,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if (icon != null) Icon(icon, size: 12, color: _foregroundColor),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: _foregroundColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
