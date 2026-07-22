import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Professional empty state shown when the user has no orders.
///
/// Displays an icon, title, subtitle, and a "Continue Shopping" button
/// that navigates back to the main shop.
class EmptyOrdersWidget extends StatelessWidget {
  const EmptyOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: 36.sp,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 20.h),

            // Title
            Text(
              'No Orders Yet',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            // Subtitle
            Text(
              'You haven\'t placed any orders yet.\nStart shopping and your orders will appear here.',
              style: AppTextStyles.body.copyWith(
                fontSize: 14.sp,
                color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),

            // Continue Shopping button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue Shopping',
                  style: AppTextStyles.button.copyWith(fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

