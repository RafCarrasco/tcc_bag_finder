import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

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

  static void warning(String message) {
    final Color warningColor = (AppColors.primary).withOpacity(0.8);

    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        backgroundColor: warningColor, 
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
