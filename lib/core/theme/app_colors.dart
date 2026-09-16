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

  // Brand Colors - Luxury Botanical Jade & Sage
  static const Color primary = Color(0xFF2E5A27); // Rich Forest Jade
  static const Color primaryLight = Color(0xFF6B9B52); // Herbal Sage
  static const Color primaryDark = Color(0xFF1B3D17); // Deep Forest Night
  static const Color secondary = Color(0xFFF7F4EC); // Warm Champagne Cream
  static const Color accent = Color(0xFF8B5E3C); // Herbal Amber

  // Basic Colors
  static const Color white = Colors.white;
  static const Color black = Color(0xFF141A15);

  // Light Mode Palette (Luxury Alabaster & Warm Pearl)
  static const Color bgLight = Color(0xFFFAF8F4);
  static const Color panelLight = Color(0xE8FFFFFF); // Frosted White Panel
  static const Color panel2Light = Color(0xD8F4F0E6); // Warm Ivory
  static const Color textLight = Color(0xFF162319); // Rich Dark Forest
  static const Color mutedLight = Color(0x9C162319); // Subtle Forest Muted
  static const Color earthLight = Color(0xFF6A4B2F);
  static const Color creamLight = Color(0xFFFFF9EC);
  static const Color goldLight = Color(0xFFD4AF37); // True Champagne Gold
  static const Color inputBgLight = Color(0xFFFFFFFF);
  static const Color bannerBgLight = primary;
  static const Color borderLight = Color(0xFFE8E2D6);

  // Dark Mode Palette (Botanical Midnight)
  static const Color bgDark = Color(0xFF070E09);
  static const Color panelDark = Color(0xD90E1B12);
  static const Color panel2Dark = Color(0xB814261A);
  static const Color textDark = Color(0xFFF2F7F2);
  static const Color mutedDark = Color(0x99F2F7F2);
  static const Color earthDark = Color(0xFFA68B6F);
  static const Color creamDark = Color(0xFF0A0802);
  static const Color goldDark = Color(0xFFF2C94C);
  static const Color inputBgDark = Color(0xFF0B140E);
  static const Color bannerBgDark = Color(0xFF0D1C11);
  static const Color borderDark = Color(0xFF1B3322);

  // Status
  static const Color success = Color(0xFF388E3C);
  static const Color error = Color(0xFFFF1744); // 100% Vivid Pure Bright Red
  static const Color pureRed = Color(0xFFFF1744); // 100% Pure Vibrant Red
  static const Color warning = Color(0xFFFFA000);

  // Vivid Pure Red Gradient
  static const LinearGradient redGradient = LinearGradient(
    colors: [Color(0xFFFF1744), Color(0xFFD50000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Legacy & Extra Mapped Colors
  static const Color leafLight = Color(0xE0F5F0D8);
  static const Color aloeLight = Color(0xD9F5EFD8);
  static const Color leafDark = Color(0xFF2F8A3B);
  static const Color aloeDark = Color(0xFF1B7B2A);

  static const Color chipSelected = primary;
  static const Color chipUnselected = Color(0xFFF2EFE8);

  static const Color bannerGradientStart = Color(0xFF5E8B4C);
  static const Color bannerGradientEnd = Color(0xFF2E5A27);

  // Luxury Gradients
  static const LinearGradient luxuryGradient = LinearGradient(
    colors: [Color(0xFF2E5A27), Color(0xFF487A36)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF3D57B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
