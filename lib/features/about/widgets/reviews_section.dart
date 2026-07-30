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
            Icon(Icons.reviews_rounded, color: AppColors.primary, size: 22.sp),
            SizedBox(width: 8.w),
            Text(
              'Customer Reviews',
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.of(context).textPrimary,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Obx(() {
          if (controller.isFakeReviewsLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (controller.fakeReviewsError.value.isNotEmpty) {
            return Text(
              controller.fakeReviewsError.value,
              style: AppTextStyles.body.copyWith(color: AppColors.error),
            );
          }

          if (controller.fakeReviews.isEmpty) {
            return Text(
              'No customer reviews available right now.',
              style: AppTextStyles.body.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
            );
          }

          return Column(
            children: controller.fakeReviews
                .map((review) => ReviewCard(review: review))
                .toList(),
          );
        }),
      ],
    );
  }
}
