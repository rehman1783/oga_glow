import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  AppTextStyles._();

  // IMPORTANT: These styles should be theme-aware.
  // Avoid hard-coding AppColors.textPrimary/textSecondary because those are light-based.

  /// Theme-aware: hardcoded black avoid karo.
  /// Agar widget/theme override karega to wo use hoga.
  static TextStyle heading1 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle heading2 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle body = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );


  static TextStyle button = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
