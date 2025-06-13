import 'package:tcc_bag_finder/app/presentation/user/auth/mixins/user_validation_mixin.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final Icon suffixIcon;
  final String hint;
  final bool isPassword;
  final String fieldType;
  final bool isRequired;
  final void Function(String)? onChanged;

  const LoginTextField({
    super.key,
    required this.suffixIcon,
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
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        final error = validateField(
          value,
          widget.hint,
          widget.fieldType,
          widget.isRequired,
        );

        return error;
      },
      obscureText: widget.isPassword,
      onChanged: (value) {
        widget.onChanged?.call(value);
        final error = validateField(
          value,
          widget.hint,
          widget.fieldType,
          widget.isRequired,
        );
        setState(() {
          errorMessage = error;
        });
      },
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
        suffixIcon: widget.suffixIcon,
        suffixIconColor: AppColors.secondaryGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          borderSide: BorderSide(
            color: AppColors.secondaryGrey, // Cor de erro
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          borderSide: BorderSide(
            color: AppColors.primary, // Cor de erro
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          borderSide: BorderSide(
            color: AppColors.error, // Cor de erro
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
