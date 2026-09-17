import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Renders a 4-card metric impact grid displaying key statistics
/// (Happy Customers, Products, Years Experience, Orders Delivered).
class AboutStatsGrid extends StatelessWidget {
  const AboutStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final stats = AboutConstants.statistics;

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
                Icons.auto_awesome_rounded,
                color: AppColors.primary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              AboutConstants.statisticsTitle,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.6,
          ),
          itemBuilder: (context, index) {
            final item = stats[index];
            final String label = item['label'] as String? ?? '';
            final dynamic val = item['value'];
            final String suffix = item['suffix'] as String? ?? '';
            final String iconName = item['icon'] as String? ?? '';

            final formattedValue = _formatValue(val) + suffix;
            final iconData = _getIconData(iconName);

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.cardBackground,
                    AppColors.primary.withValues(alpha: 0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formattedValue,
                        style: AppTextStyles.heading1.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      Icon(
                        iconData,
                        size: 20.sp,
                        color: AppColors.primary.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 12.sp,
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
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

  String _formatValue(dynamic val) {
    if (val is int) {
      if (val >= 1000) {
        return '${(val / 1000).toStringAsFixed(0)}k';
      }
      return val.toString();
    }
    return val?.toString() ?? '0';
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'favorite':
        return Icons.favorite_rounded;
      case 'inventory_2':
        return Icons.inventory_2_rounded;
      case 'calendar_today':
        return Icons.calendar_today_rounded;
      case 'check_circle':
        return Icons.verified_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}
