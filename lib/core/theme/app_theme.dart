import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.colorWhite,
    primaryColor: AppColors.colorNavyBlue,
    textTheme: GoogleFonts.dmSansTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: AppColors.colorBlack,
      displayColor: AppColors.colorBlack,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.colorNavyBlue,
      foregroundColor: AppColors.colorWhite,
    ),
    colorScheme: const ColorScheme.light(
      surface: AppColors.colorWhite,
      primary: AppColors.colorNavyBlue,
      onPrimary: AppColors.colorWhite,
      secondary: AppColors.colorSkyBlue,
      onSecondary: AppColors.colorBlack,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.colorBlack,
    primaryColor: AppColors.colorSkyBlue,
    textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: AppColors.colorWhite,
      displayColor: AppColors.colorWhite,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.colorSkyBlue,
      foregroundColor: AppColors.colorWhite,
    ),
    colorScheme: const ColorScheme.dark(
      surface: AppColors.colorBlack,
      primary: AppColors.colorSkyBlue,
      onPrimary: AppColors.colorBlack,
      secondary: AppColors.colorNavyBlue,
      onSecondary: AppColors.colorWhite,
    ),
  );
}
