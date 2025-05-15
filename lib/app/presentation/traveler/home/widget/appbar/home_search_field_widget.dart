import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeSearchFieldWidget extends StatelessWidget {
  final String hint;
  final void Function(String)? onChanged;
  const HomeSearchFieldWidget({
    super.key,
    required this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        child: TextField(
          textAlign: TextAlign.center,
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: AppColors.secondary,
            filled: true,
            border: const OutlineInputBorder(),
            hintText: hint,
            prefixIcon: Icon(
              Icons.search,
              size: AppDimensions.iconMedium,
              color: AppColors.primary,
            ),
            hintStyle: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: 0,
            ),
            prefixIconColor: AppColors.primary,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusMedium,
              ),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusMedium,
              ),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusMedium,
              ),
              borderSide: BorderSide.none,
            ),
          ),
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.secondaryGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
