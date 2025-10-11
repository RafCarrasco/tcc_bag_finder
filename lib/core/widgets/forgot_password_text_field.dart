import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import '../utils/app_text_styles.dart';
import '../utils/user_validation_mixin.dart';

class ForgotPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Icon suffixIcon;
  final String hint;
  final bool isPassword;
  final String fieldType;
  final bool isRequired;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const ForgotPasswordTextField({
    super.key,
    this.controller,
    required this.hint,
    this.onChanged,
    required this.isPassword,
    required this.fieldType,
    required this.isRequired,
    required this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  State<ForgotPasswordTextField> createState() =>
      _ForgotPasswordTextFieldState();
}

class _ForgotPasswordTextFieldState extends State<ForgotPasswordTextField>
    with ValidationMixin {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator ??
          (value) => validateField(
                value,
                widget.hint,
                widget.fieldType,
                widget.isRequired,
              ),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
          vertical: AppDimensions.paddingSmall,
        ),
        fillColor: AppColors.textFieldBackground,
        filled: true,
        border: const OutlineInputBorder(),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: AppColors.secondaryGrey,
          fontSize: AppDimensions.fontMedium,
        ),
        suffixIconColor: AppColors.secondaryGrey,
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
            : widget.suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),
      style: AppTextStyles.titleMedium.copyWith(
        color: AppColors.secondaryGrey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
