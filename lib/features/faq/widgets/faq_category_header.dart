import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/constants/faq_constants.dart';

/// A section header for a FAQ category.
///
/// Displays an icon, the category title, and a count of questions.
/// Fully theme-aware and responsive.
class FAQCategoryHeader extends StatelessWidget {
  /// The category data model.
  final FaqCategory category;

  const FAQCategoryHeader({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
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
            _mapIcon(category.icon),
            size: 20.sp,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
          SizedBox(width: 8.w),
          // Title
          Text(
            category.title,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          // Question count badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '${category.questions.length}',
              style: AppTextStyles.caption.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Maps icon name strings to Material [IconData].
  IconData _mapIcon(String iconName) {
    switch (iconName) {
      case 'local_shipping':
        return Icons.local_shipping_rounded;
      case 'autorenew':
        return Icons.autorenew_rounded;
      case 'payments':
        return Icons.payments_rounded;
      case 'spa':
        return Icons.spa_rounded;
      case 'person':
        return Icons.person_rounded;
      case 'help_outline':
        return Icons.help_outline_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}

