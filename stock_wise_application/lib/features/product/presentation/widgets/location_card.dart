import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/widgets/other/info_card.dart';

class LocationCard extends StatelessWidget {
  final List<String> locationPath;

  const LocationCard({super.key, required this.locationPath});

  String get _displayValue {
    if (locationPath.isEmpty) return 'No location';
    return locationPath.join(' > ');
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      icon: Iconsax.home_2_copy,
      label: 'Location',
      value: _displayValue,
      iconColor: AppColors.primary,
      backgroundColor: AppColors.white,
      borderColor: AppColors.border,
    );
  }
}
