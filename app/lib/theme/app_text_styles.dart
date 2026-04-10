import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _base => GoogleFonts.plusJakartaSans();

  // Headings
  static TextStyle get h1 => _base.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 1.2,
        letterSpacing: -0.5,
        color: AppColors.softCharcoal,
      );

  static TextStyle get h2 => _base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: -0.3,
        color: AppColors.softCharcoal,
      );

  static TextStyle get h3 => _base.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: -0.2,
        color: AppColors.softCharcoal,
      );

  // Body
  static TextStyle get bodyLg => _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: AppColors.softCharcoal,
      );

  static TextStyle get bodyMd => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.softCharcoal,
      );

  static TextStyle get bodySm => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.warmMutedGray,
      );

  // Labels & Buttons
  static TextStyle get labelLg => _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.0,
        letterSpacing: 0.1,
      );
      
  static TextStyle get labelMd => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.0,
        letterSpacing: 0.1,
      );
}
