import 'package:flutter/material.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;

  final String label;

  final String value;

  final Color iconColor;

  final Color backgroundColor;

  final Color borderColor;

  const InfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor = AppColors.primary,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.border,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(icon, key: ValueKey(icon), color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label.toUpperCase(),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
