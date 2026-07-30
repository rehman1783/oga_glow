import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/utils/date_formatter.dart';
import 'package:oga_glow/features/about/models/fake_review_model.dart';

class ReviewCard extends StatelessWidget {
  final FakeReview review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            backgroundImage: review.image != null && review.image!.isNotEmpty
                ? NetworkImage(review.image!)
                : null,
            child: review.image == null || review.image!.isEmpty
                ? Icon(Icons.person_rounded, color: AppColors.primary)
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.name.isNotEmpty ? review.name : 'Verified Customer',
                  style: AppTextStyles.heading2.copyWith(
                    color: colors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  DateFormatter.formatPakistanDateTime(review.createdAt),
                  style: AppTextStyles.body.copyWith(
                    color: colors.textSecondary,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  review.comment.isNotEmpty
                      ? review.comment
                      : 'Great experience with OgaGlow.',
                  style: AppTextStyles.body.copyWith(
                    color: colors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
