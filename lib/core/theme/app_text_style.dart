import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // DM Sans
  static TextStyle textStyleDmSans = GoogleFonts.dmSans();
  static TextStyle textStyleDmSansRegular = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    color: AppColors.colorWhite,
  );
  static TextStyle textStyleDmSansMedium = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    color: AppColors.colorWhite,
  );
  static TextStyle textStyleDmSansSemiBold = GoogleFonts.dmSans(
    fontWeight: FontWeight.w600,
    color: AppColors.colorWhite,
  );
  static TextStyle textStyleDmSansBold = GoogleFonts.dmSans(
    fontWeight: FontWeight.w700,
    color: AppColors.colorWhite,
  );
  static TextStyle textStyleDmSansExtraBold = GoogleFonts.dmSans(
    fontWeight: FontWeight.w800,
    color: AppColors.colorWhite,
  );

  // Inter
  static TextStyle textStyleInter = GoogleFonts.inter();
  static TextStyle textStyleInterRegular = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    color: AppColors.colorWhite,
  );
  static TextStyle textStyleInterMedium = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    color: AppColors.colorWhite,
  );
  static TextStyle textStyleInterSemiBold = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    color: AppColors.colorWhite,
  );
  static TextStyle textStyleInterBold = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    color: AppColors.colorWhite,
  );
  static TextStyle textStyleInterExtraBold = GoogleFonts.inter(
    fontWeight: FontWeight.w800,
    color: AppColors.colorWhite,
  );


}
