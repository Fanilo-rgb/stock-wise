import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

enum AlertCardVariant { warning, danger }

class AlertCardWidget extends StatelessWidget {
  final AlertCardVariant variant;
  final String imagePath;
  final String title;
  final int count;
  final String unit;
  final VoidCallback? onViewNow;

  const AlertCardWidget({
    super.key,
    required this.variant,
    required this.imagePath,
    required this.title,
    required this.count,
    this.unit = 'items',
    this.onViewNow,
  });

  bool get _isWarning => variant == AlertCardVariant.warning;

  Color get _accentColor =>
      _isWarning ? AppColors.warning600 : AppColors.danger600;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isWarning
        ? AppColors.warning50
        : AppColors.danger50;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageThumbnail(),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildTextContent(), _buildActionButton()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageThumbnail() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.all(16),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        // Optionnel : ajouter un placeholder si l'image charge mal
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyles.label.copyWith(
            color: _accentColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$count ',
                style: AppTextStyles.h2.copyWith(color: _accentColor),
              ),
              TextSpan(
                text: unit,
                style: AppTextStyles.h4.copyWith(
                  color: _accentColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onViewNow,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'View now',
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Iconsax.arrow_right_1_copy, size: 24, color: _accentColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
