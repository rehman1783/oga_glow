import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A reusable section heading widget for policy pages.
///
/// Displays a title with a decorative left accent bar. Mirrors the
/// style used in [AboutSectionTitle] and [ContactSectionTitle].
class PolicySection extends StatelessWidget {
  final String title;

  const PolicySection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
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
          // Title
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

