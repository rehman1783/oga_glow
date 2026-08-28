import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
      child: BounceTap(
        scaleBound: 0.97,
        onTap: () {
          Navigator.of(context).pop();
          onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 11.h,
          ),
          decoration: BoxDecoration(
            color: colors.panelSecondary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: colors.border.withValues(alpha: 0.6),
              width: 0.8,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.primary).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: IconTheme(
                  data: IconThemeData(
                    color: iconColor ?? AppColors.primary,
                    size: 20.sp,
                  ),
                  child: icon,
                ),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colors.textSecondary.withValues(alpha: 0.6),
                size: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}