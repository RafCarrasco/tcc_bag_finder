import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_dimensions.dart';
import '../utils/user_validation_mixin.dart';

class ForgotPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool isPassword;
  final String hint;
  final String fieldType;
  final bool isRequired;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const ForgotPasswordTextField({
    super.key,
    this.controller,
    required this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.fieldType = 'default',
    this.isRequired = true,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.inputFormatters
  });

  @override
  State<ForgotPasswordTextField> createState() => _ForgotPasswordTextFieldState();
}

class _ForgotPasswordTextFieldState extends State<ForgotPasswordTextField>
    with ValidationMixin {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
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
        prefixIcon: widget.prefixIcon ??
        Icon(
          widget.isPassword ? Icons.lock_outline : Icons.email_outlined,
          color: AppColors.primary,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primary,
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
          color: AppColors.primary,
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
