import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/widgets/app%20bar/app_bar.dart';
import 'package:stock_wise_application/core/widgets/buttons/app_button.dart';
import 'package:stock_wise_application/core/widgets/inputs/app_text_field.dart';
import 'package:stock_wise_application/core/widgets/other/card_list_section.dart';
import 'package:stock_wise_application/core/widgets/pills/app_pill.dart';
import 'package:stock_wise_application/features/location/presentation/widgets/location_tile_widget.dart';
import 'package:stock_wise_application/features/product/presentation/widgets/product_tile_widget.dart';

final List<String> categories = [
  "All",
  "Food",
  "Hygiene",
  "Cleaning",
  "Drinks",
  "Snacks",
];

String selectedCategory = "All";

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: "The smith resident",
        variant: AppBarVariant.titleWithMore,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              _searchbar(),

              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CardListSection(
                  title: "Location",
                  leadingValue: 2,
                  leadingVariant: PillVariant.success,
                  children: [
                    LocationTileWidget(
                      locationPath: ["Kitchen", "Fridge"],
                      itemCount: 30,
                    ),

                    SizedBox(height: 8),

                    LocationTileWidget(
                      locationPath: ["Kitchen", "Cupboard"],
                      itemCount: 10,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CardListSection(
                  title: "Products",
                  trailing: AppPill(
                    label: "2",
                    variant: AppPillVariant.success,
                  ),
                  children: [
                    ProductTileWidget(
                      svgPath: 'assets/icons/cooked-rice.svg',
                      name: 'Riz Basmati',
                      quantity: 2.4,
                      maxQuantity: 3,
                      unit: 'kg',
                      onTap: () => context.push("/inventory/2"),
                    ),
                    ProductTileWidget(
                      svgPath: 'assets/icons/glass-of-milk.svg',
                      name: 'Lait Candia',
                      quantity: 0.5,
                      maxQuantity: 4,
                      unit: 'L',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchbar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppTextField(
            hint: "Research ...",
            leadingIcon: Iconsax.search_normal_1_copy,
          ),
        ),

        SizedBox(height: 8),

        SizedBox(
          height: 32,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return AppButton(
                label: categories[index],
                variant: index == 0
                    ? AppButtonVariant.primary
                    : AppButtonVariant.ghost,
                size: AppButtonSize.small,
                onPressed: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
