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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shadowColor: AppColors.primary.withOpacity(0.1),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        splashColor: AppColors.primary.withOpacity(0.08),
        highlightColor: AppColors.primary.withOpacity(0.04),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isDark
                  ? AppColors.borderDark.withOpacity(0.5)
                  : AppColors.borderLight.withOpacity(0.5),
            ),
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
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
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 12.sp,
                        color: isDark
                            ? AppColors.mutedDark
                            : AppColors.mutedLight,
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
                color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
