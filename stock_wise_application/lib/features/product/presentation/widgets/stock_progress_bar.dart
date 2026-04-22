import 'package:flutter/material.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';

class StockProgressBar extends StatelessWidget {
  final double ratio;

  const StockProgressBar({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final filledWidth = totalWidth * ratio;

        return Stack(
          children: [
            Container(
              height: 4,
              width: totalWidth,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              height: 4,
              width: filledWidth,
              decoration: BoxDecoration(
                color: AppColors.success600,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        );
      },
    );
  }
}
