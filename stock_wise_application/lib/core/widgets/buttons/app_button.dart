import 'package:flutter/material.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, tertiary, danger, ghost }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  Color get _backgroundColor => switch (variant) {
    AppButtonVariant.primary => AppColors.primary600,
    AppButtonVariant.secondary => AppColors.primary100,
    AppButtonVariant.tertiary => Colors.transparent,
    AppButtonVariant.danger => AppColors.danger,
    AppButtonVariant.ghost => Colors.transparent,
  };

  Color get _foregroundColor => switch (variant) {
    AppButtonVariant.primary => AppColors.white,
    AppButtonVariant.secondary => AppColors.primary600,
    AppButtonVariant.tertiary => AppColors.primary600,
    AppButtonVariant.danger => AppColors.white,
    AppButtonVariant.ghost => AppColors.primary,
  };

  BorderSide get _borderSide => switch (variant) {
    AppButtonVariant.ghost => const BorderSide(
      color: AppColors.primary,
      width: 1.5,
    ),
    _ => BorderSide.none,
  };

  EdgeInsets get _padding => switch (size) {
    AppButtonSize.small => const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    AppButtonSize.medium => const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    AppButtonSize.large => const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
  };

  TextStyle get _textStyle => switch (size) {
    AppButtonSize.small => AppTextStyles.labelSmall,
    AppButtonSize.medium => AppTextStyles.label,
    AppButtonSize.large => AppTextStyles.labelLarge,
  };

  // Icons : small = 14, medium = 16, large = 18
  double get _iconSize => switch (size) {
    AppButtonSize.small => 14,
    AppButtonSize.medium => 16,
    AppButtonSize.large => 18,
  };

  // Spinner proportionnel aussi
  double get _spinnerSize => switch (size) {
    AppButtonSize.small => 14,
    AppButtonSize.medium => 16,
    AppButtonSize.large => 18,
  };

  // Gap entre icon et label
  double get _gap => switch (size) {
    AppButtonSize.small => 8,
    AppButtonSize.medium => 12,
    AppButtonSize.large => 14,
  };

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _backgroundColor,
        foregroundColor: _foregroundColor,
        disabledBackgroundColor: AppColors.grey100,
        disabledForegroundColor: AppColors.grey400,
        elevation: 0,
        padding: _padding,
        // Full rounded = radius tres grand, Flutter le clamp automatiquement
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: _borderSide,
        ),
        // Supprime l'overlay Material par defaut pour garder le look propre
        overlayColor: _foregroundColor.withValues(alpha: 0.08),
      ),
      child: isLoading
          ? SizedBox(
              width: _spinnerSize,
              height: _spinnerSize,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: _foregroundColor,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, size: _iconSize, color: _foregroundColor),
                  SizedBox(width: _gap),
                ],
                Text(
                  label,
                  style: _textStyle.copyWith(color: _foregroundColor),
                ),
                if (trailingIcon != null) ...[
                  SizedBox(width: _gap),
                  Icon(trailingIcon, size: _iconSize, color: _foregroundColor),
                ],
              ],
            ),
    );
  }
}
