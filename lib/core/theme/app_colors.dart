import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF6B8E23); // olive green
  static const Color primaryLight = Color(0xFFA8C686);
  static const Color accent = Color(0xFF8B5E3C); // herbal brown

  // Common basic colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Light Theme Palette (:root)
  static const Color bgLight = Color(0xFFFBFAF5);
  static const Color panelLight = Color(0xB8FFFFFF); // rgba(255, 255, 255, .72) -> 184 alpha
  static const Color panel2Light = Color(0x94FFFFFF); // rgba(255, 255, 255, .58) -> 148 alpha
  static const Color textLight = Color(0xFF142018);
  static const Color mutedLight = Color(0xB8142018); // rgba(20, 32, 24, .72) -> 184 alpha
  static const Color earthLight = Color(0xFF6A4B2F);
  static const Color creamLight = Color(0xFFFFF6DD);
  static const Color goldLight = Color(0xFFC9A84A);
  static const Color inputBgLight = Color(0xFFFFFFFF);
  static const Color bannerBgLight = primary;
  static const Color borderLight = Color(0xFFE5E0D8);

  // Dark Theme Palette (.dark)
  static const Color bgDark = Color(0xFF030A05);
  static const Color panelDark = Color(0xD90A140F); // rgba(10, 20, 15, 0.85) -> 217 alpha
  static const Color panel2Dark = Color(0xB20F1E16); // rgba(15, 30, 22, 0.7) -> 179 alpha
  static const Color textDark = Color(0xFFF1F7EF);
  static const Color mutedDark = Color(0x99F1F7EF); // rgba(241, 247, 239, 0.6) -> 153 alpha
  static const Color earthDark = Color(0xFFA68B6F);
  static const Color creamDark = Color(0xFF0A0802);
  static const Color goldDark = Color(0xFFF4D03F);
  static const Color inputBgDark = Color(0xFF020503);
  static const Color bannerBgDark = Color(0xFF0A180E);
  static const Color borderDark = Color(0xFF193223);

  // Mapped/computed values
  static bool get isDark {
    try {
      return Get.isDarkMode;
    } catch (_) {
      return false;
    }
  }

  // Theme-aware dynamic getters
  static Color get bg => isDark ? bgDark : bgLight;
  static Color get panel => isDark ? panelDark : panelLight;
  static Color get panel2 => isDark ? panel2Dark : panel2Light;
  static Color get text => isDark ? textDark : textLight;
  static Color get muted => isDark ? mutedDark : mutedLight;

  static Color get green1 => isDark ? primary : Color.lerp(primary, Colors.black, 0.3)!;
  static Color get green2 => isDark ? Color.lerp(primary, Colors.white, 0.3)! : primary;

  static Color get leaf => isDark ? Color.lerp(primary, Colors.black, 0.4)! : Color.lerp(primary, Colors.white, 0.1)!;
  static Color get aloe => isDark ? Color.lerp(primary, Colors.black, 0.6)! : Color.lerp(primary, Colors.white, 0.4)!;

  static Color get earth => isDark ? earthDark : earthLight;
  static Color get cream => isDark ? creamDark : creamLight;
  static Color get gold => isDark ? goldDark : goldLight;

  static Color get inputBg => isDark ? inputBgDark : inputBgLight;
  static Color get bannerBg => isDark ? bannerBgDark : bannerBgLight;

  // Legacy & Compatibility names (to support existing code seamlessly)
  static Color get background => bg;
  static Color get cardBackground => panel;
  static Color get border => isDark ? const Color(0xFF193223) : const Color(0xFFE5E0D8);
  static Color get textPrimary => text;
  static Color get textSecondary => muted;
  static const Color secondary = Color(0xFFF5F1E8); // Keep legacy warm cream for some layouts

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);

  // Extras
  static Color get chipSelected => primary;
  static Color get chipUnselected => isDark ? panel2 : const Color(0xFFF2F2F2);

  static Color get bannerGradientStart => isDark ? bannerBgDark : primaryLight;
  static Color get bannerGradientEnd => isDark ? bannerBgDark : primary;

  // Premium Shadow System (CSS mapped)
  static List<BoxShadow> get shadow => [
        BoxShadow(
          color: isDark
              ? const Color(0xCC000000) // rgba(0,0,0,0.8)
              : const Color(0x2E0A140C), // rgba(10,20,12,0.18)
          blurRadius: isDark ? 60 : 55,
          offset: const Offset(0, 20),
        ),
      ];

  static List<BoxShadow> get shadow2 => [
        BoxShadow(
          color: isDark
              ? const Color(0x99000000) // rgba(0,0,0,0.6)
              : const Color(0x240A140C), // rgba(10,20,12,0.14)
          blurRadius: 30,
          offset: const Offset(0, 12),
        ),
      ];

  // Border Radii (CSS mapped)
  static const double radiusVal = 18.0;
  static const double radius2Val = 26.0;

  static BorderRadius get radius => BorderRadius.circular(radiusVal);
  static BorderRadius get radius2 => BorderRadius.circular(radius2Val);
}
