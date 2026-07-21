import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A premium card widget for displaying a company value.
///
/// Shows an [icon], [title], and [description] with a subtle
/// left accent bar and elegant styling.
class ValuesCard extends StatelessWidget {
  /// Title of the value (e.g., "Quality").
  final String title;

  /// Description explaining the value.
  final String description;

  /// Icon name string mapping to Material Icons.
  final String iconName;

  const ValuesCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconName,
  });

  IconData _getIcon() {
    switch (iconName) {
      case 'workspace_premium':
        return Icons.workspace_premium_rounded;
      case 'lightbulb':
        return Icons.lightbulb_rounded;
      case 'gpp_good':
        return Icons.gpp_good_rounded;
      case 'people':
        return Icons.people_rounded;
      case 'eco':
        return Icons.eco_rounded;
      default:
        return Icons.favorite_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left accent bar
          Container(
            width: 4.w,
            height: 60.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 14.w),

          // Icon
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(_getIcon(), size: 22.sp, color: AppColors.primary),
          ),
          SizedBox(width: 12.w),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
