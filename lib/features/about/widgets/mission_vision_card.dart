import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A premium card widget for displaying mission or vision content.
///
/// Shows an [icon], [title], and [description] with gradient accents,
/// soft shadows, and elegant styling.
class MissionVisionCard extends StatelessWidget {
  /// Icon data to display at the top.
  final IconData icon;

  /// Title text (e.g., "Our Mission").
  final String title;

  /// Description / body text.
  final String description;

  const MissionVisionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with gradient background
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 26.sp, color: AppColors.white),
          ),
          SizedBox(height: 16.h),

          // Title
          Text(
            title,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 8.h),

          // Description
          Text(
            description,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              color: AppColors.of(context).textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
