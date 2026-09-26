import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/about/controllers/about_controller.dart';
import 'review_card.dart';

class ReviewsSection extends GetView<AboutController> {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                Icons.rate_review_rounded,
                color: AppColors.primary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Customer Feedback',
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.of(context).textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Obx(() {
          if (controller.isCustomerReviewsLoading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2),
              ),
            );
          }

          if (controller.customerReviewsError.value.isNotEmpty) {
            return Text(
              controller.customerReviewsError.value,
              style: AppTextStyles.body.copyWith(color: AppColors.error),
            );
          }

          if (controller.customerReviews.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'No customer reviews available yet.',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.of(context).textSecondary,
                  fontSize: 13.sp,
                ),
              ),
            );
          }

          return Column(
            children: controller.customerReviews
                .map((review) => ReviewCard(review: review))
                .toList(),
          );
        }),
      ],
    );
  }
}

