import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

abstract class GlobalSnackBar {
  static void error(String message) {
    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: AppColors.error,
        width: 500,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: Text(
          message,
          style: AppTextStyles.bodyText1.copyWith(color: AppColors.secondary),
        ),
      ));
    }
  }

  static void success(String message) {
    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: AppColors.primary,
        width: 600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: Text(
          message,
          style: AppTextStyles.bodyText1.copyWith(color: AppColors.secondary),
        ),
      ));
    }
  }

   static void info(String message) {
    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: AppColors.primary,
        width: 600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: Text(
          message,
          style: AppTextStyles.bodyText1.copyWith(color: AppColors.secondary),
        ),
      ));
    }
  }
}
