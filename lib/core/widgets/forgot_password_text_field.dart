import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import '../utils/app_text_styles.dart';
import '../utils/user_validation_mixin.dart'; // Mantendo a dependência

class AppInputTextField extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon; // Usando IconData para se alinhar ao EditProfileField
  final Widget? suffixIcon; // NOVO: Ícone suffix customizado e opcional
  final String? label; // Mudado para OPCIONAL
  final String hint;
  final bool isPassword;
  final String fieldType;
  final bool isRequired;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AppInputTextField({
    super.key,
    this.controller,
    this.label, // Mudado para OPCIONAL
    required this.hint,
    this.onChanged,
    this.isPassword = false, // Padrão é false
    this.fieldType = 'default',
    this.isRequired = true, // Padrão é true, como na lógica de validação
    this.prefixIcon, // Passamos o IconData aqui
    this.suffixIcon, // NOVO: Ícone suffix customizado
    this.keyboardType,
    this.validator,
  });

  @override
  State<AppInputTextField> createState() => _AppInputTextFieldState();
}

class _AppInputTextFieldState extends State<AppInputTextField>
    with ValidationMixin {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Define o ícone suffix a ser usado: prioriza o toggle de senha, senão usa o ícone customizado.
    final Widget? effectiveSuffixIcon = widget.isPassword
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
        : widget.suffixIcon; // Se não for senha, usa o ícone suffix passado.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Label - Apenas exibe se o label não for nulo
        if (widget.label != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
        
        // 2. TextFormField
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          // Aplica obscureText apenas se for um campo de senha E o toggle estiver ativo
          obscureText: widget.isPassword ? _obscureText : false,
          
          // Usa o validator customizado, ou o validator padrão com ValidationMixin
          validator: widget.validator ??
              (value) => validateField(
                    value,
                    widget.hint,
                    widget.fieldType,
                    widget.isRequired,
                  ),
          onChanged: widget.onChanged,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.black, // Cor do texto digitado
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            // Ícone Prefix: Estilo EditProfileField
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.primary)
                : null,
            
            // Ícone Suffix: Usa o ícone determinado pela lógica acima
            suffixIcon: effectiveSuffixIcon,
            
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: AppColors.secondaryGrey,
              fontSize: AppDimensions.fontMedium,
            ),
            
            // Estilo do campo (preenchido e bordas arredondadas)
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
              vertical: AppDimensions.paddingSmall + 4, // Ajuste para melhor visual
            ),
            
            // Bordas
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(color: AppColors.primary.withOpacity(0.4)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.6,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(
                color: AppColors.error,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              borderSide: BorderSide(color: AppColors.error, width: 1.6),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
