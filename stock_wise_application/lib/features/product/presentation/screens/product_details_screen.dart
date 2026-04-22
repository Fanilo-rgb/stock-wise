import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';
import 'package:stock_wise_application/core/widgets/app%20bar/app_bar.dart';
import 'package:stock_wise_application/core/widgets/buttons/app_button.dart';
import 'package:stock_wise_application/features/product/presentation/widgets/expiry_date_card.dart';
import 'package:stock_wise_application/features/product/presentation/widgets/location_card.dart';
import 'package:stock_wise_application/features/product/presentation/widgets/product_header_widget.dart';
import 'package:stock_wise_application/features/product/presentation/widgets/stock_progress_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  String get unit => "kg";

  int get maxQuantity => 5;
  int get quantity => 2;

  double get _ratio =>
      maxQuantity > 0 ? (quantity / maxQuantity).clamp(0.0, 1.0) : 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: "Product details",
        variant: AppBarVariant.full,

        onBackTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              ProductHeaderWidget(
                svgPath: "assets/icons/cooked-rice.svg",
                name: "Riz Basmati",
                category: "Food",
              ),

              const SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stock state',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textBody,
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

                  const SizedBox(height: 16),

                  ExpiryDateCard(
                    expiryDate: DateTime.now().add(Duration(days: 12)),
                  ),

                  const SizedBox(height: 8),

                  LocationCard(locationPath: ["Kitchen", "fridge"]),

                  const SizedBox(height: 16),

                  AppButton(
                    leadingIcon: Iconsax.okb_okb,
                    label: "Marck as Consumed",
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
