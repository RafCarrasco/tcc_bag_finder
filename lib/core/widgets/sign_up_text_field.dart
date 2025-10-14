import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_dimensions.dart';
import '../utils/user_validation_mixin.dart';

class SignUpTextField extends StatefulWidget {
  final String hint;
  final Function(String) onChanged;
  final bool isPassword;
  final bool isRequired;
  final String fieldType;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const SignUpTextField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.isPassword = false,
    this.isRequired = true,
    this.fieldType = '',
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.validator,
  });

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField>
    with ValidationMixin {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType ??
          (widget.fieldType == 'email'
              ? TextInputType.emailAddress
              : TextInputType.text),
      validator: widget.validator ??
          (value) => validateField(
                value,
                widget.hint,
                widget.fieldType,
                widget.isRequired,
              ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon ??
              (widget.isPassword ? Icons.lock_outline : Icons.person_outline),
          color: AppColors.primary,
        ),
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
        hintText: widget.hint,
        hintStyle: AppTextStyles.bodyText1.copyWith(
          color: AppColors.secondaryGrey,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1.2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: AppTextStyles.bodyText1.copyWith(fontSize: 16),
    );
  }
}
