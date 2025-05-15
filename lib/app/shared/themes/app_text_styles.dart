import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle display = TextStyle(
    color: AppColors.primary,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headline = TextStyle(
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleMedium = TextStyle(
    color: AppColors.primary,
    fontSize: 16.0,
  );

  static TextStyle bodyText1 = TextStyle(
    color: AppColors.primary,
    fontSize: 12.0,
  );

  static TextStyle bodyText2 = TextStyle(
    color: AppColors.primary,
    fontSize: 8.0,
  );

  static TextStyle button = TextStyle(
    color: AppColors.secondary,
    fontSize: 20.0,
  );

  static TextStyle placeholder = TextStyle(
    color: AppColors.secondary,
    fontSize: 12.0,
  );
}
