import 'package:flutter/material.dart';
import 'package:oga_glow/core/theme/app_colors.dart';

extension ThemeExtensions on BuildContext {
  /// Fast access to ThemeData
  ThemeData get theme => Theme.of(this);

  /// Fast access to ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Fast access to TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Check if dark mode is active
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get theme-aware AppThemeColors palette for current context
  AppThemeColors get colors => AppColors.of(this);
}
