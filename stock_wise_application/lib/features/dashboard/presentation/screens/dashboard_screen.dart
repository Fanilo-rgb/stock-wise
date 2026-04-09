import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/widgets/app%20bar/app_bar.dart';
import 'package:stock_wise_application/core/widgets/other/card_list_section.dart';
import 'package:stock_wise_application/features/dashboard/presentation/widgets/alert_card.dart';
import 'package:stock_wise_application/features/dashboard/presentation/widgets/alert_product_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: "Dashboard",
        variant: AppBarVariant.titleWithMore,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // les warning card
              CardListSection(
                leadingValue: 2,
                leadingVariant: PillVariant.warning,
                title: 'Warning',
                children: [
                  AlertCardWidget(
                    variant: AlertCardVariant.warning,
                    imagePath: 'assets/pictures/no-results-box.png',
                    title: 'Critical stock',
                    count: 3,
                    onViewNow: () {},
                  ),

                  AlertCardWidget(
                    variant: AlertCardVariant.danger,
                    imagePath: 'assets/pictures/expiry-box.png',
                    title: 'Expired product',
                    count: 2,
                    onViewNow: () {},
                  ),
                ],
              ),

              // Soon to expire card
              CardListSection(
                title: "Soon to expire",
                leadingValue: Iconsax.calendar_remove_copy,
                leadingVariant: PillVariant.warning,
                children: [
                  AlertProductCard(
                    name: "Olive",
                    category: "Food",
                    remainingDay: 6,
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
