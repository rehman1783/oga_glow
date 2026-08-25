import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Centralized, safe snackbar / toast utility.
///
/// Prevents GetX overlay crashes, ensures proper constraints,
/// and provides a consistent, luxury look & feel.
class CustomSnackbar {
  CustomSnackbar._();

  static void showSuccess({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      title: title,
      message: message,
      icon: Icons.check_circle_rounded,
      iconColor: const Color(0xFF4CAF50),
      borderColor: const Color(0xFF4CAF50).withValues(alpha: 0.35),
      backgroundColor: const Color(0xFF1E2D24),
      duration: duration,
    );
  }

  static void showError({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 4),
    Widget? actionButton,
  }) {
    _show(
      title: title,
      message: message,
      icon: Icons.error_outline_rounded,
      iconColor: const Color(0xFFEF5350),
      borderColor: const Color(0xFFEF5350).withValues(alpha: 0.35),
      backgroundColor: const Color(0xFF2D1E1E),
      duration: duration,
      actionButton: actionButton,
    );
  }

  static void showInfo({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      title: title,
      message: message,
      icon: Icons.info_outline_rounded,
      iconColor: AppColors.primaryLight,
      borderColor: AppColors.primary.withValues(alpha: 0.35),
      backgroundColor: const Color(0xFF1E2620),
      duration: duration,
    );
  }

  static void _show({
    required String title,
    required String message,
    required IconData icon,
    required Color iconColor,
    required Color borderColor,
    required Color backgroundColor,
    required Duration duration,
    Widget? actionButton,
  }) {
    try {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Get.rawSnackbar(
        titleText: Text(
          title,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ),
        messageText: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.3,
                ),
              ),
            ),
            if (actionButton != null) ...[
              SizedBox(width: 8.w),
              actionButton,
            ],
          ],
        ),
        icon: Container(
          margin: EdgeInsets.only(left: 12.w, right: 8.w),
          child: Icon(icon, color: iconColor, size: 24.sp),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        borderRadius: 16.r,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        duration: duration,
        borderColor: borderColor,
        borderWidth: 1,
        snackStyle: SnackStyle.FLOATING,
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } catch (_) {
      // Gracefully prevent crashes if invoked during an unstable frame
    }
  }
}
