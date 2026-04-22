import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';
import 'package:stock_wise_application/core/widgets/app%20bar/app_bar.dart';
import 'package:stock_wise_application/core/widgets/buttons/app_button.dart';
import 'package:stock_wise_application/features/shopping/presentation/widgets/shopping_item_tile.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: "Shopping",
        variant: AppBarVariant.titleWithMore,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AddItemRow(onAdd: () {}),

                  const SizedBox(height: 28),

                  _SectionLabel(label: 'Urgent restock', isUrgent: true),

                  const SizedBox(height: 12),

                  ShoppingItemTile(
                    icon: Iconsax.dropbox_copy,
                    name: "u1",
                    subtitle: "Out of stock",
                    isChecked: false,
                    onToggle: () {},
                  ),

                  const SizedBox(height: 20),

                  _SectionLabel(label: 'Routine essentials', isUrgent: false),

                  const SizedBox(height: 12),

                  ShoppingItemTile(
                    icon: Iconsax.health_copy,
                    name: "Liquid Soap",
                    subtitle: "Regularly purchased • Every 2 weeks",
                    isChecked: true,
                    onToggle: () {},
                  ),

                  _BottomActions(onValidate: () {}, onShare: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddItemRow extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onAdd;

  // ignore: unused_element_parameter
  const _AddItemRow({this.controller, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: AppTextStyles.body.copyWith(color: AppColors.textDark),
            onSubmitted: (_) => onAdd(),
            decoration: InputDecoration(
              hintText: 'Add custom item...',
              hintStyle: AppTextStyles.body.copyWith(
                color: AppColors.textMuted,
              ),
              filled: true,
              fillColor: AppColors.grey50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Add button
        AppButton(
          label: 'Add',
          leadingIcon: Icons.add,
          onPressed: onAdd,
          variant: AppButtonVariant.primary,
          size: AppButtonSize.large,
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final bool isUrgent;

  const _SectionLabel({required this.label, required this.isUrgent});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: AppTextStyles.caption.copyWith(
        color: isUrgent ? AppColors.danger600 : AppColors.textMuted,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final VoidCallback onValidate;
  final VoidCallback onShare;

  const _BottomActions({required this.onValidate, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Validate Purchases — full width primary
          SizedBox(
            width: double.infinity,
            height: 56,
            child: AppButton(
              leadingIcon: Iconsax.shopping_bag_copy,
              label: "Validate Purchases",
              onPressed: onValidate,
              size: AppButtonSize.large,
            ),
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: AppButton(
              leadingIcon: Iconsax.share_copy,
              label: "Share list",
              onPressed: onShare,
              variant: AppButtonVariant.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
