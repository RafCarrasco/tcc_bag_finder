import 'package:bag_finder/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String)? onChanged;
  final bool isPassword;
  final String fieldType;
  final bool isRequired;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.isPassword = false,
    this.fieldType = '',
    this.isRequired = false,
    this.prefixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  String? _validator(String? value) {
    if (widget.isRequired && (value == null || value.trim().isEmpty)) {
      return 'Campo obrigatório';
    }

    if (widget.fieldType == 'email' &&
        value != null &&
        value.isNotEmpty &&
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'E-mail inválido';
    }

    if (widget.fieldType == 'phone' &&
        value != null &&
        value.isNotEmpty &&
        !RegExp(r'^\(?\d{2}\)?\s?\d{4,5}-?\d{4}$').hasMatch(value)) {
      return 'Telefone inválido';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.controller == null ? widget.initialValue : null,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      validator: _validator,
      keyboardType: _getKeyboardType(widget.fieldType),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  TextInputType _getKeyboardType(String fieldType) {
    switch (fieldType) {
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'number':
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}
