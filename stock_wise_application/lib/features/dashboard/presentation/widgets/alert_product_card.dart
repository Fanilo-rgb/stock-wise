import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

class AlertProductCard extends StatelessWidget {
  final String name;
  final String category;
  final int remainingDay;
  final VoidCallback? onCardClicked;

  const AlertProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.remainingDay,
    this.onCardClicked,
  });

  Color get _backgroundColor => AppColors.warning100;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      width: 148,
      padding: const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 18),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: [
              _iconWraper(),
              Text(
                "J - $remainingDay",
                style: AppTextStyles.label.copyWith(
                  color: AppColors.warning700,
                ),
              ),
            ],
          ),

          Text(
            name,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.warning900,
            ),
          ),

          Text(
            category,
            style: AppTextStyles.caption.copyWith(color: AppColors.grey600),
          ),
        ],
      ),
    );
  }

  Widget _iconWraper() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(child: Icon(Iconsax.milk_copy, size: 18)),
    );
  }
}
