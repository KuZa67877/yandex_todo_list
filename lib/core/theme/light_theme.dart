import 'package:flutter/material.dart';
import '../resourses/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightBackPrimary,
    scaffoldBackgroundColor: AppColors.lightBackSecondary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBackSecondary,
      foregroundColor: AppColors.lightLabelPrimary,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightLabelPrimary,
      secondary: AppColors.lightLabelSecondary,
      onPrimary: AppColors.lightLabelTertiary,
      onSecondary: AppColors.lightLabelDisable,
      error: AppColors.lightColorRed,
      background: AppColors.lightBackPrimary,
      surface: AppColors.lightBackSecondary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.lightBackSecondary,
      filled: true,
      hintStyle: TextStyle(color: AppColors.lightLabelTertiary),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightSupportSeparator),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
