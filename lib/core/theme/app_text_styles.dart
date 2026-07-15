import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  AppTextStyles._();

  // IMPORTANT: These styles should be theme-aware.
  // Avoid hard-coding AppColors.textPrimary/textSecondary because those are light-based.

  static TextStyle heading1 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    // Use Theme color dynamically when used with copyWith or theme defaults.
    color: Colors.black,
  );

  static TextStyle heading2 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle body = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  static TextStyle button = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
