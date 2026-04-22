import 'package:flutter/material.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

class ShoppingItemTile extends StatelessWidget {
  final IconData icon;

  final String name;

  final String subtitle;

  final bool isChecked;

  final VoidCallback onToggle;

  const ShoppingItemTile({
    super.key,
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.isChecked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            _CircularIconContainer(icon: icon, isChecked: isChecked),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textDark,
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            _AnimatedCheckbox(isChecked: isChecked),
          ],
        ),
      ),
    );
  }
}

class _CircularIconContainer extends StatelessWidget {
  final IconData icon;
  final bool isChecked;

  const _CircularIconContainer({required this.icon, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isChecked ? AppColors.primary200 : AppColors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 20,
          color: isChecked ? AppColors.primary700 : AppColors.grey500,
        ),
      ),
    );
  }
}

class _AnimatedCheckbox extends StatelessWidget {
  final bool isChecked;

  const _AnimatedCheckbox({required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isChecked ? AppColors.primary700 : Colors.transparent,
        border: Border.all(
          color: isChecked ? AppColors.primary700 : AppColors.grey300,
          width: 2,
        ),
      ),
      child: isChecked
          ? const Icon(Icons.check, size: 16, color: AppColors.white)
          : null,
    );
  }
}
