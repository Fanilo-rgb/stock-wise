import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stock_wise_application/core/theme/app_colors.dart';
import 'package:stock_wise_application/core/theme/app_text_styles.dart';
import 'package:stock_wise_application/core/widgets/app%20bar/app_bar.dart';
import 'package:stock_wise_application/core/widgets/buttons/app_button.dart';

const List<String> _kCategories = [
  'Food',
  'Hygiene',
  'Utility',
  'Health',
  'Other',
];

const List<String> _kUnits = ['Units', 'kg', 'g', 'L', 'mL', 'pieces'];

const List<String> _kLocations = [
  'Kitchen',
  'Bathroom',
  'Pantry',
  'Garage',
  'Bedroom',
  'Living Room',
];

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCategory = _kCategories.first;
  int _quantity = 1;
  String _selectedUnit = _kUnits.first;
  DateTime? _expiryDate;
  String _selectedLocation = _kLocations.first;

  String get _formattedDate {
    final d = _expiryDate;
    if (d == null) return 'mm/dd/yyyy';
    return '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _expiryDate = picked);
    }
  }

  void _decrementQuantity() {
    if (_quantity > 0) setState(() => _quantity--);
  }

  void _incrementQuantity() {
    setState(() => _quantity++);
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: "Manual entry",
        variant: AppBarVariant.backWithTitleRight,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionLabel('Product Name'),
              const SizedBox(height: 8),
              _AppTextField(
                controller: _productNameController,
                hint: 'e.g. Organic Olive Oil',
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),

              const SizedBox(height: 28),

              _SectionLabel('Category'),
              const SizedBox(height: 12),
              _CategorySelector(
                categories: _kCategories,
                selected: _selectedCategory,
                onChanged: (v) => setState(() => _selectedCategory = v),
              ),

              const SizedBox(height: 28),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionLabel('Current Quantity'),
                        const SizedBox(height: 8),
                        _QuantityStepper(
                          value: _quantity,
                          onDecrement: _decrementQuantity,
                          onIncrement: _incrementQuantity,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionLabel('Unit'),
                        const SizedBox(height: 8),
                        _AppDropdown<String>(
                          value: _selectedUnit,
                          items: _kUnits,
                          itemLabel: (u) => u,
                          onChanged: (v) {
                            if (v != null) setState(() => _selectedUnit = v);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              _SectionLabel('Expiry Date'),
              const SizedBox(height: 8),
              _DateField(
                displayText: _formattedDate,
                hasValue: _expiryDate != null,
                onTap: _pickDate,
              ),

              const SizedBox(height: 28),

              _SectionLabel('Storage Location'),
              const SizedBox(height: 8),
              _AppDropdown<String>(
                value: _selectedLocation,
                items: _kLocations,
                itemLabel: (l) => l,
                onChanged: (v) {
                  if (v != null) setState(() => _selectedLocation = v);
                },
              ),

              const SizedBox(height: 28),

              _SectionLabel('Purchase Price (Optional)'),
              const SizedBox(height: 8),
              _AppTextField(
                controller: _priceController,
                hint: '0.00',
                prefix: Text(
                  '\$  ',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: AppButton(
                  label: "Save Product",
                  onPressed: () {},
                  size: AppButtonSize.large,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.label.copyWith(
        color: AppColors.textBody,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const _AppTextField({
    required this.controller,
    required this.hint,
    this.prefix,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: AppTextStyles.body.copyWith(color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted),
        prefix: prefix,
        filled: true,
        fillColor: AppColors.grey50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
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
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onChanged;

  const _CategorySelector({
    required this.categories,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = category == selected;
        return GestureDetector(
          onTap: () => onChanged(category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary600 : AppColors.grey100,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              category,
              style: AppTextStyles.label.copyWith(
                color: isSelected ? AppColors.white : AppColors.textBody,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _QuantityStepper({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StepperButton(icon: Iconsax.minus_copy, onTap: onDecrement),
          Text(
            '$value',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          _StepperButton(icon: Iconsax.add_copy, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepperButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Icon(icon, size: 18, color: AppColors.textBody),
      ),
    );
  }
}

class _AppDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;

  const _AppDropdown({
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(100),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Iconsax.arrow_down_1_copy,
            size: 18,
            color: AppColors.textMuted,
          ),
          style: AppTextStyles.body.copyWith(color: AppColors.textDark),
          dropdownColor: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemLabel(item),
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String displayText;
  final bool hasValue;
  final VoidCallback onTap;

  const _DateField({
    required this.displayText,
    required this.hasValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                displayText,
                style: AppTextStyles.body.copyWith(
                  color: hasValue ? AppColors.textDark : AppColors.textMuted,
                ),
              ),
            ),
            const Icon(
              Iconsax.calendar_1_copy,
              size: 20,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
