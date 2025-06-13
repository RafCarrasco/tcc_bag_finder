import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import '../utils/app_text_styles.dart';
import '../utils/user_validation_mixin.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool isPassword;
  final String fieldType;
  final bool isRequired;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.onChanged,
    required this.isPassword,
    required this.fieldType,
    required this.isRequired,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField>
    with ValidationMixin {
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingSmall,
      ),
      child: TextFormField(
        validator: (value) {
          final error = validateField(
            value,
            widget.hintText,
            widget.fieldType,
            widget.isRequired,
          );
          setState(() {
            errorMessage = error;
          });

          return error;
        },
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.secondaryGrey,
          fontWeight: FontWeight.bold,
        ),
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
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          filled: true,
          hintStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
            ),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
        ),
      ),
    );
  }
}
