import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionTitle({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.heading1.copyWith(
            fontSize: 17.sp,
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),

        if (onSeeAll != null)
          BounceTap(
            scaleBound: 0.94,
            onTap: onSeeAll!,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "See All",
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5.sp,
                  ),
                ),
                SizedBox(width: 3.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 11.sp,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
