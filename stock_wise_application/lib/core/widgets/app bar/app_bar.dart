import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';

enum AppBarVariant {
  // Back | Title | Search + Grid + More
  full,
  // Title | More
  titleWithMore,
  // Back | Title (a droite)
  backWithTitleRight,
  // Title | bouton texte custom
  titleWithAction,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarVariant variant;

  // Variant full
  final VoidCallback? onMoreTap;

  // Variant titleWithMore
  final VoidCallback? onMoreTapSimple;

  // Variant backWithTitleRight
  final VoidCallback? onBackTap;

  // Variant titleWithAction
  final String? actionLabel;
  final VoidCallback? onActionTap;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.variant,
    this.onMoreTap,
    this.onMoreTapSimple,
    this.onBackTap,
    this.actionLabel,
    this.onActionTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  Widget _iconButton(IconData icon, VoidCallback? onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 20, color: AppColors.textDark),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 56,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: switch (variant) {
        AppBarVariant.full => _buildFull(),
        AppBarVariant.titleWithMore => _buildTitleWithMore(),
        AppBarVariant.backWithTitleRight => _buildBackWithTitleRight(),
        AppBarVariant.titleWithAction => _buildTitleWithAction(),
      },
    );
  }

  Widget _buildFull() {
    return Row(
      children: [
        _iconButton(Iconsax.arrow_left_2_copy, onBackTap),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.h5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _iconButton(Iconsax.more_copy, onMoreTap),
      ],
    );
  }

  // ─── Variant 2 : Title | More ───────────────────────────────────────────────
  Widget _buildTitleWithMore() {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.h5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _iconButton(Iconsax.more_copy, onMoreTapSimple),
      ],
    );
  }

  // ─── Variant 3 : Back | Title a droite ─────────────────────────────────────
  Widget _buildBackWithTitleRight() {
    return Row(
      children: [
        _iconButton(Iconsax.arrow_left_2_copy, onBackTap),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.h5,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ─── Variant 4 : Title | bouton texte ──────────────────────────────────────
  Widget _buildTitleWithAction() {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.h5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onActionTap,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textMuted,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(actionLabel!, style: AppTextStyles.bodySmall),
          ),
      ],
    );
  }
}
