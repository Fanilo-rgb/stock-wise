import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

class LocationTileWidget extends StatelessWidget {
  final List<String> locationPath;

  final int itemCount;

  final VoidCallback? onTap;

  const LocationTileWidget({
    super.key,
    required this.locationPath,
    required this.itemCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Iconsax.box,
                color: AppColors.primary950,
                size: 20,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BreadcrumbRow(locationPath: locationPath),
                  const SizedBox(height: 2),
                  Text(
                    '$itemCount items',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Iconsax.arrow_right_1_copy, color: AppColors.textDark),
          ],
        ),
      ),
    );
  }
}

class _BreadcrumbRow extends StatelessWidget {
  final List<String> locationPath;

  const _BreadcrumbRow({required this.locationPath});

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (int i = 0; i < locationPath.length; i++) {
      children.add(
        Text(
          locationPath[i],
          style: AppTextStyles.label.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

      if (i < locationPath.length - 1) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.circle, color: AppColors.textDark, size: 5),
          ),
        );
      }
    }

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}
