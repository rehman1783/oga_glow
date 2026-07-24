import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppThemeColors {
  final Color background;
  final Color panel;
  final Color panelSecondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color earth;
  final Color cream;
  final Color gold;
  final Color inputBg;
  final Color bannerBg;
  final Color border;
  final Color cardBackground;

  const AppThemeColors({
    required this.background,
    required this.panel,
    required this.panelSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.earth,
    required this.cream,
    required this.gold,
    required this.inputBg,
    required this.bannerBg,
    required this.border,
    required this.cardBackground,
  });

  static const AppThemeColors light = AppThemeColors(
    background: AppColors.bgLight,
    panel: AppColors.panelLight,
    panelSecondary: AppColors.panel2Light,
    textPrimary: AppColors.textLight,
    textSecondary: AppColors.mutedLight,
    earth: AppColors.earthLight,
    cream: AppColors.creamLight,
    gold: AppColors.goldLight,
    inputBg: AppColors.inputBgLight,
    bannerBg: AppColors.bannerBgLight,
    border: AppColors.borderLight,
    cardBackground: AppColors.white,
  );

  static const AppThemeColors dark = AppThemeColors(
    background: AppColors.bgDark,
    panel: AppColors.panelDark,
    panelSecondary: AppColors.panel2Dark,
    textPrimary: AppColors.textDark,
    textSecondary: AppColors.mutedDark,
    earth: AppColors.earthDark,
    cream: AppColors.creamDark,
    gold: AppColors.goldDark,
    inputBg: AppColors.inputBgDark,
    bannerBg: AppColors.bannerBgDark,
    border: AppColors.borderDark,
    cardBackground: AppColors.panelDark,
  );
}

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF6B8E23); // Olive green
  static const Color primaryLight = Color(0xFFA8C686);
  static const Color secondary = Color(0xFFF5F1E8); // Warm cream
  static const Color accent = Color(0xFF8B5E3C); // Herbal brown

  // Basic Colors
  static const Color white = Colors.white;
  static const Color black = Color(0xFF1E1E1E);

  // Light Mode Palette
  static const Color bgLight = Color(0xFFFBFAF5);
  static const Color panelLight = Color.fromARGB(184, 255, 255, 255); // rgba(255,255,255,.72)
  static const Color panel2Light = Color.fromARGB(148, 255, 255, 255); // rgba(255,255,255,.58)
  static const Color textLight = Color(0xFF142018);
  static const Color mutedLight = Color.fromARGB(184, 20, 32, 24); // rgba(20,32,24,.72)
  static const Color earthLight = Color(0xFF6A4B2F);
  static const Color creamLight = Color(0xFFFFF6DD);
  static const Color goldLight = Color(0xFFC9A84A);
  static const Color inputBgLight = Color(0xFFFFFFFF);
  static const Color bannerBgLight = primary;
  static const Color borderLight = Color(0xFFE5E0D8);

  // Dark Mode Palette
  static const Color bgDark = Color(0xFF030A05);
  static const Color panelDark = Color.fromARGB(217, 10, 20, 15); // rgba(10,20,15,0.85)
  static const Color panel2Dark = Color.fromARGB(179, 15, 30, 22); // rgba(15,30,22,0.70)
  static const Color textDark = Color(0xFFF1F7EF);
  static const Color mutedDark = Color.fromARGB(153, 241, 247, 239); // rgba(241,247,239,0.60)
  static const Color earthDark = Color(0xFFA68B6F);
  static const Color creamDark = Color(0xFF0A0802);
  static const Color goldDark = Color(0xFFF4D03F);
  static const Color inputBgDark = Color(0xFF020503);
  static const Color bannerBgDark = Color(0xFF0A180E);
  static const Color borderDark = Color(0xFF193223);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);

  // Legacy & Extra Mapped Colors
  static const Color leafLight = Color(0xE0F5F0D8);
  static const Color aloeLight = Color(0xD9F5EFD8);
  static const Color leafDark = Color(0xFF2F8A3B);
  static const Color aloeDark = Color(0xFF1B7B2A);

  static const Color chipSelected = primary;
  static const Color chipUnselected = Color(0xFFF2F2F2);

  static const Color bannerGradientStart = Color(0xFFA8C686);
  static const Color bannerGradientEnd = Color(0xFF6B8E23);

  /// Theme-aware dynamic color resolver
  static AppThemeColors of([BuildContext? context]) {
    final ctx = context ?? Get.context;
    if (ctx != null) {
      try {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return isDark ? AppThemeColors.dark : AppThemeColors.light;
      } catch (_) {}
    }
    return AppThemeColors.light;
  }

  // Dynamic getters for seamless theme adaptation
  static Color get background => of().background;
  static Color get cardBackground => of().cardBackground;
  static Color get panel => of().panel;
  static Color get panelSecondary => of().panelSecondary;
  static Color get border => of().border;
  static Color get textPrimary => of().textPrimary;
  static Color get textSecondary => of().textSecondary;
  static Color get earth => of().earth;
  static Color get cream => of().cream;
  static Color get gold => of().gold;
  static Color get inputBg => of().inputBg;
  static Color get bannerBg => of().bannerBg;
}
