import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return BounceTap(
      scaleBound: 0.90,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 66.w,
            height: 66.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.15),
                  AppColors.primaryLight.withValues(alpha: 0.06),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.25),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 28.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 11.5.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}