import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_text_styles.dart';

class AddCollaboratorTextField extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool isPassword;
  final String fieldType;
  final bool isRequired;
  final void Function(String)? onChanged;

  const AddCollaboratorTextField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.onChanged,
    required this.isPassword,
    required this.fieldType,
    required this.isRequired,
  });

  @override
  State<AddCollaboratorTextField> createState() =>
      _AddCollaboratorTextFieldState();
}

class _AddCollaboratorTextFieldState extends State<AddCollaboratorTextField> {
  String? errorMessage;

  String? validateField(
    String? value,
    String hintText,
    String fieldType,
    bool isRequired,
  ) {
    if (isRequired && (value == null || value.trim().isEmpty)) {
      return '$hintText é obrigatório';
    }

    if (fieldType == 'email' && value != null) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Email inválido';
      }
    }

    if (fieldType == 'phone' && value != null) {
      final phoneRegex = RegExp(r'^\(?\d{2}\)?[\s-]?\d{5}-?\d{4}$');
      if (!phoneRegex.hasMatch(value)) {
        return 'Telefone inválido';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingSmall),
      child: TextFormField(
        obscureText: widget.isPassword,
        validator: (value) {
          final error = validateField(
            value,
            widget.hintText,
            widget.fieldType,
            widget.isRequired,
          );
          setState(() => errorMessage = error);
          return error;
        },
        onChanged: widget.onChanged,
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.secondaryGrey,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: AppColors.primary.withOpacity(0.3),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingLarge,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall * 0.5),
            borderSide: BorderSide.none,
          ),
          filled: true,
          hintStyle: const TextStyle(
            color: Colors.black87,
            fontSize: AppDimensions.fontMedium,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
            ),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: AppDimensions.iconMedium,
            minHeight: AppDimensions.iconMedium,
          ),
        ),
      ),
    );
  }
}
