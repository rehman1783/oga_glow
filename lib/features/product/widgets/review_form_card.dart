import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/custom_text_field.dart';
import 'package:oga_glow/core/widgets/primary_button.dart';
import 'package:oga_glow/features/product/controllers/product_reviews_controller.dart';

class ReviewFormCard extends GetView<ProductReviewsController> {
  const ReviewFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write a Review',
            style: AppTextStyles.heading2.copyWith(
              color: colors.textPrimary,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Obx(() {
            return Row(
              children: List.generate(5, (index) {
                final selected = controller.rating.value > index;
                return IconButton(
                  onPressed: () => controller.rating.value = index + 1,
                  icon: Icon(
                    selected ? Icons.star_rounded : Icons.star_border_rounded,
                    color: selected ? Colors.amber : colors.textSecondary,
                    size: 28.sp,
                  ),
                );
              }),
            );
          }),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: controller.nameController,
            labelHint: 'Your Name',
            hintText: 'Enter your name',
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: controller.emailController,
            labelHint: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            hintText: 'you@example.com',
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: controller.reviewController,
            labelHint: 'Review',
            hintText: 'Share your experience with this product',
          ),
          SizedBox(height: 12.h),
          Obx(() {
            return controller.reviewFormError.value.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      controller.reviewFormError.value,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  );
          }),
          Obx(() {
            return PrimaryButton(
              title: 'Submit Review',
              isLoading: controller.isSubmittingReview.value,
              onPressed: () => controller.submitReview(),
            );
          }),
        ],
      ),
    );
  }
}
