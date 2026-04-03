import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

class ThemeTestScreen extends StatelessWidget {
  const ThemeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'StockWise',
          style: AppTextStyles.h3.copyWith(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/icons/banana.svg", width: 64),
            const Icon(Iconsax.home_2_copy),
            // ━━━ FONTS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            const Text('— TYPOGRAPHIES —', style: AppTextStyles.labelSmall),
            const SizedBox(height: 12),
            const Text('H1 - Lexend Bold 32', style: AppTextStyles.h1),
            const Text('H2 - Lexend Bold 24', style: AppTextStyles.h2),
            const Text('H3 - Lexend SemiBold 20', style: AppTextStyles.h3),
            const Text('H4 - Lexend SemiBold 18', style: AppTextStyles.h4),
            const Text(
              'Body Large - Regular 16',
              style: AppTextStyles.bodyLarge,
            ),
            const Text('Body - Regular 14', style: AppTextStyles.body),
            const Text(
              'Body Small - Regular 12',
              style: AppTextStyles.bodySmall,
            ),
            const Text(
              'Label Large - SemiBold 16',
              style: AppTextStyles.labelLarge,
            ),
            const Text('Label - Medium 14', style: AppTextStyles.label),
            const Text('Caption - Light 11', style: AppTextStyles.caption),

            const SizedBox(height: 32),

            // ━━━ COULEURS PRINCIPALES ━━━━━━━━━━━━━━━━━
            const Text(
              '— COULEURS PRINCIPALES —',
              style: AppTextStyles.labelSmall,
            ),
            const SizedBox(height: 12),
            _ColorRow('Primary', AppColors.primary),
            _ColorRow('Success', AppColors.success),
            _ColorRow('Warning', AppColors.warning),
            _ColorRow('Danger', AppColors.danger),

            const SizedBox(height: 32),

            // ━━━ SHADES PRIMARY ━━━━━━━━━━━━━━━━━━━━━━━
            const Text('— SHADES PRIMARY —', style: AppTextStyles.labelSmall),
            const SizedBox(height: 12),
            _ColorRow('Primary 50', AppColors.primary50, textDark: true),
            _ColorRow('Primary 100', AppColors.primary100, textDark: true),
            _ColorRow('Primary 200', AppColors.primary200, textDark: true),
            _ColorRow('Primary 300', AppColors.primary300, textDark: true),
            _ColorRow('Primary 400', AppColors.primary400, textDark: true),
            _ColorRow('Primary 500', AppColors.primary500),
            _ColorRow('Primary 600', AppColors.primary600),
            _ColorRow('Primary 700', AppColors.primary700),
            _ColorRow('Primary 800', AppColors.primary800),
            _ColorRow('Primary 900', AppColors.primary900),
            _ColorRow('Primary 950', AppColors.primary950),

            const SizedBox(height: 32),

            // ━━━ GREYS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            const Text('— GREYS —', style: AppTextStyles.labelSmall),
            const SizedBox(height: 12),
            _ColorRow('Grey 50', AppColors.grey50, textDark: true),
            _ColorRow('Grey 100', AppColors.grey100, textDark: true),
            _ColorRow('Grey 200', AppColors.grey200, textDark: true),
            _ColorRow('Grey 300', AppColors.grey300, textDark: true),
            _ColorRow('Grey 400', AppColors.grey400, textDark: true),
            _ColorRow('Grey 500', AppColors.grey500),
            _ColorRow('Grey 600', AppColors.grey600),
            _ColorRow('Grey 700', AppColors.grey700),
            _ColorRow('Grey 800', AppColors.grey800),
            _ColorRow('Grey 900', AppColors.grey900),
            _ColorRow('Grey 950', AppColors.grey950),
          ],
        ),
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  final String label;
  final Color color;
  final bool textDark;

  const _ColorRow(this.label, this.color, {this.textDark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      height: 44,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(
          color: textDark ? AppColors.textDark : AppColors.white,
        ),
      ),
    );
  }
}
