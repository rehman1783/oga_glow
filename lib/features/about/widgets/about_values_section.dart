import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Renders "Why Choose Us" & Company Values grid cards.
class AboutValuesSection extends StatelessWidget {
  const AboutValuesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final features = AboutConstants.whyChooseUsFeatures;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.verified_user_rounded,
                color: AppColors.primary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              AboutConstants.whyChooseUsTitle,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: features.length,
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final item = features[index];
            final title = item['title'] ?? '';
            final description = item['description'] ?? '';
            final iconName = item['icon'] ?? 'star';
            final iconData = _getIconData(iconName);

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: colors.border.withValues(alpha: 0.6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.primaryLight.withValues(alpha: 0.08),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconData,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.heading2.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          description,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 12.sp,
                            color: colors.textSecondary,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'star':
        return Icons.workspace_premium_rounded;
      case 'verified':
        return Icons.verified_user_rounded;
      case 'local_shipping':
        return Icons.local_shipping_rounded;
      case 'sentiment_satisfied':
        return Icons.sentiment_very_satisfied_rounded;
      case 'security':
        return Icons.shield_rounded;
      case 'monetization_on':
        return Icons.savings_rounded;
      default:
        return Icons.check_circle_rounded;
    }
  }
}
