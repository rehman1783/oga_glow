import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 92.w,
              height: 92.h,
              decoration: BoxDecoration(
                color: AppColors.of(context).cardBackground,
                borderRadius: BorderRadius.circular(26.r),
                border: Border.all(color: AppColors.of(context).border),
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 48.sp,
                color: AppColors.of(context).earth,
              ),
            ),

            SizedBox(height: 18.h),

            Text(
              'Your Wishlist is Empty',
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.of(context).textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10.h),

            Text(
              'Save products you love and they will appear here.',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

