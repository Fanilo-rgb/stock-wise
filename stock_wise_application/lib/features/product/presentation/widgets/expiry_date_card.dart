import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/widgets/other/info_card.dart';

enum _ExpiryState { normal, warning, expired }

class ExpiryDateCard extends StatelessWidget {
  final DateTime? expiryDate;

  final int warningThresholdDays;

  const ExpiryDateCard({
    super.key,
    required this.expiryDate,
    this.warningThresholdDays = 30,
  });

  _ExpiryState get _state {
    final date = expiryDate;
    if (date == null) return _ExpiryState.normal;

    final daysLeft = date.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return _ExpiryState.expired;
    if (daysLeft <= warningThresholdDays) return _ExpiryState.warning;
    return _ExpiryState.normal;
  }

  Color get _iconColor => switch (_state) {
    _ExpiryState.normal => AppColors.primary,
    _ExpiryState.warning => AppColors.warning,
    _ExpiryState.expired => AppColors.danger,
  };

  Color get _borderColor => switch (_state) {
    _ExpiryState.normal => AppColors.border,
    _ExpiryState.warning => AppColors.warning200,
    _ExpiryState.expired => AppColors.danger200,
  };

  Color get _backgroundColor => switch (_state) {
    _ExpiryState.normal => AppColors.white,
    _ExpiryState.warning => AppColors.warning50,
    _ExpiryState.expired => AppColors.danger50,
  };

  String get _formattedDate {
    final date = expiryDate;
    if (date == null) return 'No expiry date';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      icon: Iconsax.calendar_1_copy,
      label: 'Expiry date',
      value: _formattedDate,
      iconColor: _iconColor,
      backgroundColor: _backgroundColor,
      borderColor: _borderColor,
    );
  }
}
