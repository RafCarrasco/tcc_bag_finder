import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.secondary,
    splashColor: Colors.transparent,
    shadowColor: AppColors.primary,
    fontFamily: GoogleFonts.sora().fontFamily,
    dividerColor: AppColors.primary,
    dividerTheme: DividerThemeData(
      color: AppColors.primary,
      thickness: AppDimensions.borderMedium,
      indent: 5,
      endIndent: 5,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(AppColors.secondary),
      side: BorderSide(
        color: AppColors.primary,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          style: BorderStyle.solid,
          width: 1.5,
          color: AppColors.primary,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
        textStyle: WidgetStatePropertyAll(
          AppTextStyles.button.copyWith(
            fontSize: 16,
          ),
        ),
        elevation: const WidgetStatePropertyAll(8),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSmall,
            ),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            vertical: AppDimensions.paddingLarge,
            horizontal: AppDimensions.paddingExtraLarge,
          ),
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.grey;
      }),
    ),
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusLarge,
          ),
        ),
        alignment: AlignmentDirectional.center,
        backgroundColor: AppColors.secondary,
        surfaceTintColor: AppColors.secondary),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.display,
      headlineLarge: AppTextStyles.headline,
      titleMedium: AppTextStyles.titleMedium,
      bodyLarge: AppTextStyles.bodyText1,
      bodyMedium: AppTextStyles.bodyText2,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.primary, width: 1.2),
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusSmall,
        ),
      ),
      color: AppColors.secondary,
      elevation: 8,
      shadowColor: AppColors.primary,
      surfaceTintColor: AppColors.secondary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.textFieldBackground,
      contentPadding: const EdgeInsets.only(
        left: AppDimensions.paddingMedium,
        right: AppDimensions.paddingMedium,
        top: AppDimensions.paddingExtraLarge,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        gapPadding: AppDimensions.paddingSmall,
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppDimensions.borderThin * 1.5,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        gapPadding: AppDimensions.paddingSmall,
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppDimensions.borderThin * 1.5,
          style: BorderStyle.solid,
        ),
      ),
      floatingLabelStyle: AppTextStyles.headline,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        gapPadding: AppDimensions.paddingSmall,
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppDimensions.borderThin * 1.5,
          style: BorderStyle.solid,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.primary,
      size: AppDimensions.iconLarge,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(
          AppColors.primary,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.secondary,
      surfaceTintColor: AppColors.secondary,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.secondary,
      error: AppColors.error,
      shadow: AppColors.primary,
      onError: AppColors.error,
      surface: AppColors.secondary,
      onSurface: AppColors.secondary,
    ),
  );
}
