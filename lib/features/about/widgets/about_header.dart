import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Hero / Header section for the About Us screen.
///
/// Displays a logo icon, large heading, and a premium subtitle
/// inside a gradient container with soft shadows.
class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.15),
            AppColors.primaryLight.withOpacity(0.05),
            AppColors.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo / Icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.spa_rounded,
              size: 38.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 20.h),

          // Heading
          Text(
            AboutConstants.heroTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1.copyWith(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12.h),

          // Subtitle
          Text(
            AboutConstants.heroSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
