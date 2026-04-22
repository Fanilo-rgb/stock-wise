import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

class ProductHeaderWidget extends StatelessWidget {
  /// Asset path of the SVG illustration (e.g. 'assets/icons/rice.svg').
  final String svgPath;

  /// Display name of the product.
  final String name;

  /// Category label displayed inside the chip below the name.
  final String category;

  const ProductHeaderWidget({
    super.key,
    required this.svgPath,
    required this.name,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circular icon background
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.primary50,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset(svgPath, fit: BoxFit.contain),
        ),

        const SizedBox(width: 16),

        // Name + category chip
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: AppTextStyles.h3),
            const SizedBox(height: 6),
            _CategoryChip(label: category),
          ],
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBody),
      ),
    );
  }
}
