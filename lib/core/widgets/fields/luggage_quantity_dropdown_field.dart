import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controller/luggage_quantity_dropdown_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/user_validation_mixin.dart';

class LuggageQuantityDropdownField extends StatefulWidget {
  final int initialQuantity;
  final String hintText;
  final String fieldType;
  final bool isRequired;
  final void Function(int?)? onChanged;
  const LuggageQuantityDropdownField({
    super.key,
    required this.initialQuantity,
    required this.hintText,
    required this.fieldType,
    required this.isRequired,
    this.onChanged,
  });

  @override
  State<LuggageQuantityDropdownField> createState() =>
      _LuggageQuantityDropdownFieldState();
}

class _LuggageQuantityDropdownFieldState
    extends State<LuggageQuantityDropdownField> with ValidationMixin {
  String? errorMessage;
  int selectedQuantity = 1;
  final List<int> quantities = List<int>.generate(10, (index) => index + 1);
  final LuggageQuantityDropdownController _controller =
      Modular.get<LuggageQuantityDropdownController>();

  @override
  void initState() {
    super.initState();
    selectedQuantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingSmall,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<int>(
          hint: Text(
            widget.hintText,
            textAlign: TextAlign.left,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.secondaryGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          validator: (value) {
            final error = validateField(
              value.toString(),
              widget.hintText,
              widget.fieldType,
              widget.isRequired,
            );
            setState(() {
              errorMessage = error;
            });

            return error;
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: AppColors.primary.withOpacity(
              0.3,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingLarge,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            hintStyle: TextStyle(
              color: AppColors.secondaryGrey,
              fontSize: AppDimensions.fontMedium,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSmall,
              ),
              child: AppIconsSecondaryGrey.luggageIcon,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: AppDimensions.iconMedium,
              minHeight: AppDimensions.iconMedium,
            ),
          ),
          items: quantities
              .map((
                quantity,
              ) =>
                  DropdownMenuItem<int>(
                    alignment: Alignment.center,
                    value: quantity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AppIconsSecondaryGrey.luggageIcon,
                        Text(
                          quantity.toString(),
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.secondaryGrey,
                                    fontSize: AppDimensions.fontMedium,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          value: _controller.value,
          onChanged: (
            int? value,
          ) {
            setState(
              () {
                _controller.onChange(
                  value,
                );
                widget.onChanged?.call(value);
              },
            );
          },
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall * 0.5,
              ),
              color: AppColors.secondary,
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.zero,
            overlayColor: WidgetStatePropertyAll(
              AppColors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
