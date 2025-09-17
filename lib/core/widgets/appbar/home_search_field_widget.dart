import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_text_styles.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: AppDimensions.iconMedium,
            color: AppColors.primary,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: 14,
          ),
        ),
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.secondaryGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
