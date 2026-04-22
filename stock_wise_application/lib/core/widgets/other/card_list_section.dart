import 'package:flutter/material.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';
import 'package:stock_wise_application/core/widgets/buttons/app_button.dart';

enum PillVariant { neutral, danger, warning, success }

class CardListSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onViewMore;

  // Nouveaux paramètres
  final dynamic leadingValue; // Reçoit int ou IconData
  final PillVariant leadingVariant;
  final Widget? trailing; // Le widget après le titre

  const CardListSection({
    super.key,
    required this.title,
    required this.children,
    this.leadingValue,
    this.leadingVariant = PillVariant.neutral,
    this.trailing,
    this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: title,
          leadingValue: leadingValue,
          leadingVariant: leadingVariant,
          trailing: trailing,
          onViewMore: onViewMore,
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final dynamic leadingValue;
  final PillVariant leadingVariant;
  final Widget? trailing;
  final VoidCallback? onViewMore;

  const _SectionHeader({
    required this.title,
    this.leadingValue,
    required this.leadingVariant,
    this.trailing,
    this.onViewMore,
  });

  // Logique pour résoudre les couleurs selon la variante
  Color get _getBgColor {
    switch (leadingVariant) {
      case PillVariant.danger:
        return AppColors.danger50;
      case PillVariant.warning:
        return AppColors.warning50;
      case PillVariant.success:
        return AppColors.success50;
      default:
        return Colors.black.withValues(alpha: 0.05);
    }
  }

  Color get _getContentColor {
    switch (leadingVariant) {
      case PillVariant.danger:
        return AppColors.danger600;
      case PillVariant.warning:
        return AppColors.warning600;
      case PillVariant.success:
        return AppColors.success600;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leadingValue != null) ...[_buildPill(), const SizedBox(width: 8)],

        Text(title, style: AppTextStyles.h5),

        if (trailing != null) ...[const SizedBox(width: 8), trailing!],

        if (onViewMore != null) ...[
          const Spacer(),
          AppButton(
            label: "View more",
            variant: AppButtonVariant.tertiary,
            size: AppButtonSize.small,
            onPressed: onViewMore,
          ),
        ],
      ],
    );
  }

  Widget _buildPill() {
    return Container(
      height: 24,
      constraints: const BoxConstraints(minWidth: 24),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: _getBgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      alignment: Alignment.center,
      child: _buildLeadingContent(),
    );
  }

  Widget _buildLeadingContent() {
    final color = _getContentColor;

    if (leadingValue is int) {
      return Text(
        '$leadingValue',
        style: AppTextStyles.label.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          height: 1.1,
        ),
      );
    } else if (leadingValue is IconData) {
      return Icon(leadingValue as IconData, size: 14, color: color);
    }
    return const SizedBox.shrink();
  }
}
