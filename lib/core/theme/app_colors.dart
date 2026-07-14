import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors (CSS `--color-primary` equivalent)
  static const Color primary = Color(0xFF6B8E23); // olive green
  static const Color primaryLight = Color(0xFFA8C686);
  static const Color secondary = Color(0xFFF5F1E8); // warm cream
  static const Color accent = Color(0xFF8B5E3C); // herbal brown

  // Basic Colors
  static const Color white = Colors.white;
  static const Color black = Color(0xFF1E1E1E);

  // Light (CSS `:root`)
  static const Color bgLight = Color(0xFFFBFAF5); // --bg
  static const Color panelLight = Color.fromARGB(
    184,
    255,
    255,
    255,
  ); // rgba(255,255,255,.72)
  static const Color panel2Light = Color.fromARGB(
    148,
    255,
    255,
    255,
  ); // rgba(255,255,255,.58)
  static const Color textLight = Color(0xFF142018); // --text
  static const Color mutedLight = Color.fromARGB(
    184,
    20,
    32,
    24,
  ); // rgba(20,32,24,.72)
  static const Color earthLight = Color(0xFF6A4B2F); // --earth
  static const Color creamLight = Color(0xFFFFF6DD); // --cream
  static const Color goldLight = Color(0xFFC9A84A); // --gold

  // Dark (CSS `.dark`)
  static const Color bgDark = Color(0xFF030A05); // --bg
  static const Color panelDark = Color.fromARGB(
    217,
    10,
    20,
    15,
  ); // rgba(10,20,15,0.85)
  static const Color panel2Dark = Color.fromARGB(
    179,
    15,
    30,
    22,
  ); // rgba(15,30,22,0.7)
  static const Color textDark = Color(0xFFF1F7EF); // --text
  static const Color mutedDark = Color.fromARGB(
    153,
    241,
    247,
    239,
  ); // rgba(241,247,239,0.6)
  static const Color earthDark = Color(0xFFA68B6F); // --earth
  static const Color creamDark = Color(0xFF0A0802); // --cream
  static const Color goldDark = Color(0xFFF4D03F); // --gold

  // Inputs / banners
  static const Color inputBgLight = Color(0xFFFFFFFF); // --input-bg
  static const Color inputBgDark = Color(0xFF020503); // --input-bg

  static const Color bannerBgLight = primary; // --banner-bg
  static const Color bannerBgDark = Color(0xFF0A180E); // --banner-bg

  // Borders
  static const Color borderLight = Color(0xFFE5E0D8);
  static const Color borderDark = Color.fromARGB(255, 25, 50, 35);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);

  // Extra mapped colors (approx)
  // Note: Color constants must be valid ARGB (0xAARRGGBB)
  static const Color leafLight = Color(
    0xE0F5F0D8,
  ); // approx mix(primary, white 10%)
  static const Color aloeLight = Color(
    0xD9F5EFD8,
  ); // approx mix(primary, white 40%)
  static const Color leafDark = Color(
    0xFF2F8A3B,
  ); // approx mix(primary, black 40%)
  static const Color aloeDark = Color(
    0xFF1B7B2A,
  ); // approx mix(primary, black 60%)

  // Derived (used widely by current widgets / themes)
  static Color get background => bgLight;
  static Color get cardBackground => white;
  static Color get border => borderLight;
  static Color get textPrimary => textLight;
  static Color get textSecondary => Color.fromARGB(255, 109, 119, 109);

  // Legacy names used by Theme for chip etc.
  static const Color chipSelected = primary;
  static const Color chipUnselected = Color(0xFFF2F2F2);

  static const Color bannerGradientStart = Color(0xFFA8C686);
  static const Color bannerGradientEnd = Color(0xFF6B8E23);
}
