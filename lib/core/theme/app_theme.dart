import 'package:flutter/material.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Scaffold Background
    scaffoldBackgroundColor: AppColors.bgLight,

    // Primary Color
    primaryColor: AppColors.primary,

    // Color Scheme
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textLight,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.textLight,
      outline: AppColors.borderLight,
      surfaceContainer: AppColors.panelLight,
      surfaceContainerHigh: AppColors.panel2Light,
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgLight,
      foregroundColor: AppColors.textLight,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppTextStyles.heading2.copyWith(color: AppColors.textLight),
      iconTheme: const IconThemeData(
        color: AppColors.textLight,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderLight),
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.bgLight,
      modalBackgroundColor: AppColors.bgLight,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),

    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.textLight,
      contentTextStyle: AppTextStyles.body.copyWith(color: AppColors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Drawer Theme
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.bgLight,
      surfaceTintColor: Colors.transparent,
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.bgLight,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.mutedLight,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // Navigation Bar Theme
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.bgLight,
      indicatorColor: AppColors.primary.withValues(alpha: 0.15),
      labelTextStyle: WidgetStateProperty.all(
        AppTextStyles.caption.copyWith(color: AppColors.textLight),
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.borderLight,
      thickness: 1,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBgLight,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.mutedLight),
      labelStyle: AppTextStyles.body.copyWith(color: AppColors.textLight),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.borderLight,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.borderLight,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: AppTextStyles.button,
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.chipUnselected,
      labelStyle: AppTextStyles.body.copyWith(color: AppColors.textLight),
      secondaryLabelStyle: AppTextStyles.body.copyWith(
        color: AppColors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: BorderSide.none,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1.copyWith(color: AppColors.textLight),
      headlineMedium: AppTextStyles.heading2.copyWith(color: AppColors.textLight),
      bodyLarge: AppTextStyles.body.copyWith(color: AppColors.textLight),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.textLight),
      bodySmall: AppTextStyles.caption.copyWith(color: AppColors.mutedLight),
      labelLarge: AppTextStyles.label.copyWith(color: AppColors.textLight),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.bgDark,
    primaryColor: AppColors.primary,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.panel2Dark,
      onSecondary: AppColors.textDark,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.panelDark,
      onSurface: AppColors.textDark,
      outline: AppColors.borderDark,
      surfaceContainer: AppColors.panelDark,
      surfaceContainerHigh: AppColors.panel2Dark,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgDark,
      foregroundColor: AppColors.textDark,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppTextStyles.heading2.copyWith(color: AppColors.textDark),
      iconTheme: const IconThemeData(
        color: AppColors.textDark,
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.panelDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderDark),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.panelDark,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.panelDark,
      modalBackgroundColor: AppColors.panelDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.panel2Dark,
      contentTextStyle: AppTextStyles.body.copyWith(color: AppColors.textDark),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.bgDark,
      surfaceTintColor: Colors.transparent,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.bgDark,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.mutedDark,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.bgDark,
      indicatorColor: AppColors.primary.withValues(alpha: 0.2),
      labelTextStyle: WidgetStateProperty.all(
        AppTextStyles.caption.copyWith(color: AppColors.textDark),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.borderDark,
      thickness: 1,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBgDark,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.mutedDark),
      labelStyle: AppTextStyles.body.copyWith(color: AppColors.textDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.borderDark,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.borderDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: AppTextStyles.button,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    ),

    chipTheme: ChipThemeData(
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.panel2Dark,
      labelStyle: AppTextStyles.body.copyWith(color: AppColors.textDark),
      secondaryLabelStyle: AppTextStyles.body.copyWith(
        color: AppColors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: BorderSide.none,
    ),

    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1.copyWith(color: AppColors.textDark),
      headlineMedium: AppTextStyles.heading2.copyWith(color: AppColors.textDark),
      bodyLarge: AppTextStyles.body.copyWith(color: AppColors.textDark),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.textDark),
      bodySmall: AppTextStyles.caption.copyWith(color: AppColors.mutedDark),
      labelLarge: AppTextStyles.label.copyWith(color: AppColors.textDark),
    ),

    iconTheme: const IconThemeData(
      color: AppColors.textDark,
    ),
  );
}
