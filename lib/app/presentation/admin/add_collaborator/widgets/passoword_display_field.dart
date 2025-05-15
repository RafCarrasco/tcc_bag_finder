import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/generate_random_password.dart';
import 'package:flutter/material.dart';

class PasswordDisplayField extends StatefulWidget {
  final void Function(String) onPasswordRefresh;

  const PasswordDisplayField({
    super.key,
    required this.onPasswordRefresh,
  });

  @override
  State<PasswordDisplayField> createState() => _PasswordDisplayFieldState();
}

class _PasswordDisplayFieldState extends State<PasswordDisplayField> {
  final TextEditingController _passwordController = TextEditingController();

  void _refreshPassword() {
    final String newPassword = generateRandomPassword(
      length: 12,
    );

    _passwordController.text = newPassword;

    widget.onPasswordRefresh(
      newPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingSmall,
      ),
      child: TextFormField(
        readOnly: true,
        controller: _passwordController,
        decoration: InputDecoration(
          fillColor: AppColors.primary.withOpacity(
            0.3,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingLarge,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSmall * 0.5,
            ),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSmall * 0.5,
            ),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSmall * 0.5,
            ),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSmall * 0.5,
            ),
            borderSide: BorderSide.none,
          ),
          filled: true,
          hintStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
            ),
            child: AppIconsSecondaryGrey.passwordIcon,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: AppDimensions.iconMedium,
            minHeight: AppDimensions.iconMedium,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
            ),
            child: IconButton(
              onPressed: _refreshPassword,
              alignment: Alignment.center,
              icon: Icon(
                Icons.refresh,
                size: AppDimensions.iconMedium,
                color: AppColors.secondaryGrey,
              ),
            ),
          ),
        ),
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.secondaryGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
