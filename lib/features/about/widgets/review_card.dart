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
    const rating = 5;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: colors.border.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
                ? Icon(Icons.person_rounded, color: AppColors.primary, size: 20.sp)
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review.name.isNotEmpty ? review.name : 'Verified Customer',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading2.copyWith(
                          color: colors.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 11.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Verified',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                // Star Ratings
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: index < rating ? const Color(0xFFFFB800) : colors.textSecondary.withValues(alpha: 0.4),
                          size: 14.sp,
                        );
                      }),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      DateFormatter.formatPakistanDateTime(review.createdAt),
                      style: AppTextStyles.body.copyWith(
                        color: colors.textSecondary,
                        fontSize: 10.5.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  review.comment.isNotEmpty
                      ? review.comment
                      : 'Great experience with OGAGLOW.',
                  style: AppTextStyles.body.copyWith(
                    color: colors.textSecondary,
                    fontSize: 12.5.sp,
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
