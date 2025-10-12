import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class EditProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool enabled;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTogglePassword;

  const EditProfileTextField({ // Nome do construtor renomeado
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          enabled: enabled,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary),
            // O ícone deve refletir o estado atual, ou seja, se está obscurecendo (isPassword é true), 
            // o ícone deve ser 'visibility' para indicar que pode ser clicado para 'ver'.
            suffixIcon: onTogglePassword != null 
                ? IconButton(
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary.withOpacity(0.4)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 1.6),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
