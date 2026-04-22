import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';
import 'package:stock_wise_application/features/product/presentation/widgets/stock_progress_bar.dart';

class ProductTileWidget extends StatelessWidget {
  final String svgPath;

  final String name;

  final double quantity;

  final double maxQuantity;

  final String unit;

  final VoidCallback? onTap;

  const ProductTileWidget({
    super.key,
    required this.svgPath,
    required this.name,
    required this.quantity,
    required this.maxQuantity,
    required this.unit,
    this.onTap,
  });

  double get _ratio =>
      maxQuantity > 0 ? (quantity / maxQuantity).clamp(0.0, 1.0) : 0.0;

  int get _percent => (_ratio * 100).round();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(svgPath, width: 40, height: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: AppTextStyles.h5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_percent % in stock',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.success600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${quantity % 1 == 0 ? quantity.toInt() : quantity}$unit in total',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),

            const SizedBox(height: 6),

            StockProgressBar(ratio: _ratio),
          ],
        ),
      ),
    );
  }
}
