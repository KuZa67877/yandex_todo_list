import 'package:flutter/material.dart';

import '../resourses/colors.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkBackPrimary,
    scaffoldBackgroundColor: AppColors.darkBackSecondary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackSecondary,
      foregroundColor: AppColors.darkLabelPrimary,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkLabelPrimary,
      secondary: AppColors.darkLabelSecondary,
      onPrimary: AppColors.darkLabelTertiary,
      onSecondary: AppColors.darkLabelDisable,
      error: AppColors.darkColorRed,
      background: AppColors.darkBackPrimary,
      surface: AppColors.darkBackSecondary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.darkBackSecondary,
      filled: true,
      hintStyle: TextStyle(color: AppColors.darkLabelTertiary),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkSupportSeparator),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
