import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import '../utils/app_text_styles.dart';
import '../utils/user_validation_mixin.dart';

class LoginTextField extends StatefulWidget {
  final Icon prefixIcon;
  final String hint;
  final bool isPassword;
  final String fieldType;
  final bool isRequired;
  final void Function(String)? onChanged;

  const LoginTextField({
    super.key,
    required this.prefixIcon,
    required this.hint,
    this.onChanged,
    required this.isPassword,
    required this.fieldType,
    required this.isRequired,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> with ValidationMixin {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return validateField(
          value,
          widget.hint,
          widget.fieldType,
          widget.isRequired,
        );
      },
      obscureText: widget.isPassword ? _obscureText : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
          vertical: AppDimensions.paddingLarge,
        ),
        fillColor: AppColors.textFieldBackground,
        filled: true,
        border: const OutlineInputBorder(),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: AppColors.secondaryGrey,
          fontSize: AppDimensions.fontMedium,
        ),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColors.secondaryGrey,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.secondaryGrey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      style: AppTextStyles.titleMedium.copyWith(
        color: AppColors.secondaryGrey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
