import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A premium header widget for individual policy screens.
///
/// Displays an icon inside a circular container with a gradient background,
/// the policy title, last updated date, and intro text.
class PolicyHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String lastUpdated;
  final String description;

  const PolicyHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.lastUpdated,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.15),
            AppColors.primaryLight.withOpacity(0.05),
            AppColors.secondary.withOpacity(isDark ? 0.0 : 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.12)),
      ),
      child: Column(
        children: [
          // Icon
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(icon, size: 30.sp, color: AppColors.primary),
          ),
          SizedBox(height: 16.h),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 6.h),

          // Last updated
          Text(
            lastUpdated,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              fontSize: 12.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
