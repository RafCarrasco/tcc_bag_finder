import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_text_styles.dart';

class LoginTextField extends StatefulWidget {
  final String hint;
  final Function(String) onChanged;
  final bool isPassword;
  final bool isRequired;
  final String fieldType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  const LoginTextField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.isPassword = false,
    this.isRequired = false,
    this.fieldType = '',
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      keyboardType: widget.fieldType == 'email'
          ? TextInputType.emailAddress
          : TextInputType.text,
      validator: (value) {
        if (widget.isRequired && (value == null || value.isEmpty)) {
          return 'Campo obrigatório';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon ?? (widget.isPassword ? Icons.lock_outline : Icons.email_outlined),
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
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: AppTextStyles.bodyText1.copyWith(fontSize: 16),
    );
  }
}
