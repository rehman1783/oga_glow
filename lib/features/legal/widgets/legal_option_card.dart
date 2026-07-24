import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A reusable card widget for listing legal options.
///
/// Displays an icon, title, description, and a chevron arrow with
/// ripple animation and elevation. Fully theme-aware.
class LegalOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const LegalOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.1),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        splashColor: AppColors.primary.withValues(alpha: 0.08),
        highlightColor: AppColors.primary.withValues(alpha: 0.04),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: AppColors.of(context).border,
            ),
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(icon, size: 26.sp, color: AppColors.primary),
              ),
              SizedBox(width: 14.w),

              // Title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.of(context).textSecondary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // Chevron
              Icon(
                Icons.chevron_right_rounded,
                size: 24.sp,
                color: AppColors.of(context).textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
