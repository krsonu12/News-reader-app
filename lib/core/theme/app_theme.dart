import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'brand_theme_extension.dart';

class AppTheme {
  static ThemeData lightTheme(double fontSize) {
    final base = ThemeData.light();
    final textTheme = GoogleFonts.dmSansTextTheme(base.textTheme)
        .apply(
          bodyColor: AppColors.colorBlack,
          displayColor: AppColors.colorBlack,
        )
        .copyWith(
          bodyLarge: base.textTheme.bodyLarge?.copyWith(fontSize: fontSize),
          bodyMedium: base.textTheme.bodyMedium?.copyWith(fontSize: fontSize),
          bodySmall: base.textTheme.bodySmall?.copyWith(
            fontSize: fontSize * 0.9,
          ),
          titleMedium: base.textTheme.titleMedium?.copyWith(
            fontSize: fontSize + 2,
          ),
          titleLarge: base.textTheme.titleLarge?.copyWith(
            fontSize: fontSize + 3,
          ),
          labelLarge: base.textTheme.labelLarge?.copyWith(fontSize: fontSize),
        );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.colorWhite,
      primaryColor: AppColors.colorNavyBlue,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.colorNavyBlue,
        foregroundColor: AppColors.colorWhite,
        elevation: 2,
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.colorWhite,
      ),
      colorScheme: const ColorScheme.light(
        surface: AppColors.colorWhite,
        primary: AppColors.colorNavyBlue,
        onPrimary: AppColors.colorWhite,
        secondary: AppColors.colorSkyBlue,
        onSecondary: AppColors.colorBlack,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.colorGrey4,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: textTheme,
      extensions: const <ThemeExtension<dynamic>>[
        BrandTheme(
          primaryBrand: AppColors.colorNavyBlue,
          secondaryBrand: AppColors.colorSkyBlue,
          cardRadius: 16,
          cardElevation: 4,
        ),
      ],
    );
  }

  static ThemeData darkTheme(double fontSize) {
    final base = ThemeData.dark();
    final textTheme = GoogleFonts.dmSansTextTheme(base.textTheme)
        .apply(
          bodyColor: AppColors.colorWhite,
          displayColor: AppColors.colorWhite,
        )
        .copyWith(
          bodyLarge: base.textTheme.bodyLarge?.copyWith(fontSize: fontSize),
          bodyMedium: base.textTheme.bodyMedium?.copyWith(fontSize: fontSize),
          bodySmall: base.textTheme.bodySmall?.copyWith(
            fontSize: fontSize * 0.9,
          ),
          titleMedium: base.textTheme.titleMedium?.copyWith(
            fontSize: fontSize + 2,
          ),
          titleLarge: base.textTheme.titleLarge?.copyWith(
            fontSize: fontSize + 3,
          ),
          labelLarge: base.textTheme.labelLarge?.copyWith(fontSize: fontSize),
        );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.colorBlack,
      primaryColor: AppColors.colorSkyBlue,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.colorSkyBlue,
        foregroundColor: AppColors.colorWhite,
        elevation: 2,
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.colorDarkBoxBackground,
      ),
      colorScheme: const ColorScheme.dark(
        surface: AppColors.colorBlack,
        primary: AppColors.colorSkyBlue,
        onPrimary: AppColors.colorBlack,
        secondary: AppColors.colorNavyBlue,
        onSecondary: AppColors.colorWhite,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.colorDarkBoxBackground,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: textTheme,
      extensions: const <ThemeExtension<dynamic>>[
        BrandTheme(
          primaryBrand: AppColors.colorSkyBlue,
          secondaryBrand: AppColors.colorNavyBlue,
          cardRadius: 16,
          cardElevation: 4,
        ),
      ],
    );
  }
}
