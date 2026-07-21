import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Reusable section title widget for the About Us screen.
///
/// Displays an icon and a title with a decorative left accent bar.
/// Follows the same pattern as [ContactSectionTitle].
class AboutSectionTitle extends StatelessWidget {
  /// The icon to display alongside the title.
  final IconData icon;

  /// The section heading text.
  final String title;

  const AboutSectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          // Accent bar
          Container(
            width: 4.w,
            height: 22.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 10.w),
          // Icon
          Icon(
            icon,
            size: 20.sp,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
          SizedBox(width: 8.w),
          // Title
          Text(
            title,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
