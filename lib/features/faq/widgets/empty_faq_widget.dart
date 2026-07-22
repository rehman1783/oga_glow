import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/faq_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A professional empty state widget shown when no FAQs match the search.
///
/// Displays an icon, a title, and a subtitle with a suggestion.
/// Fully theme-aware and responsive.
class EmptyFAQWidget extends StatelessWidget {
  const EmptyFAQWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon container
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 36.sp,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 20.h),

            // Title
            Text(
              FaqConstants.noResultsTitle,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            // Subtitle
            Text(
              FaqConstants.noResultsSubtitle,
              style: AppTextStyles.body.copyWith(
                fontSize: 14.sp,
                color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

