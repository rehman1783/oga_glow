import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A card widget for showcasing a "Why Choose Us" feature.
///
/// Displays an [icon] (by name), [title], and [description]
/// with a clean, premium card design.
class WhyChooseUsCard extends StatelessWidget {
  /// Title of the feature (e.g., "Premium Products").
  final String title;

  /// Short description of the feature.
  final String description;

  /// Icon name string (maps to Material Icons).
  final String iconName;

  const WhyChooseUsCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconName,
  });

  IconData _getIcon() {
    switch (iconName) {
      case 'star':
        return Icons.star_rounded;
      case 'verified':
        return Icons.verified_rounded;
      case 'local_shipping':
        return Icons.local_shipping_rounded;
      case 'sentiment_satisfied':
        return Icons.sentiment_satisfied_alt_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'monetization_on':
        return Icons.monetization_on_rounded;
      default:
        return Icons.check_circle_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(_getIcon(), size: 18.sp, color: AppColors.primary),
          ),
          SizedBox(height: 8.h),

          // Title
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 2.h),

          // Description
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(
              fontSize: 11.sp,
              color: AppColors.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
