import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/faq_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// An expandable card that displays a FAQ question and its answer.
///
/// Uses [ExpansionTile] under the hood with custom styling for a premium
/// look. Fully theme-aware and responsive.
class FAQCard extends StatelessWidget {
  /// The FAQ question data to display.
  final FaqQuestion faq;

  const FAQCard({
    super.key,
    required this.faq,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark
              ? AppColors.borderDark.withOpacity(0.4)
              : AppColors.borderLight.withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          listTileTheme: const ListTileThemeData(
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          initiallyExpanded: false,
          // Smooth expand/collapse animation
          expansionAnimationStyle: AnimationStyle(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
          ),
          leading: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.help_outline_rounded,
              size: 18.sp,
              color: AppColors.primary,
            ),
          ),
          title: Text(
            faq.question,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.3,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.expand_more_rounded,
            size: 22.sp,
            color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
          ),
          collapsedShape: const Border(),
          shape: const Border(),
          collapsedIconColor:
              isDark ? AppColors.mutedDark : AppColors.mutedLight,
          iconColor: AppColors.primary,
          children: [
            // Answer section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.08),
                ),
              ),
              child: Text(
                faq.answer,
                style: AppTextStyles.body.copyWith(
                  fontSize: 13.sp,
                  color: isDark
                      ? AppColors.textDark.withOpacity(0.85)
                      : AppColors.textLight.withOpacity(0.75),
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

