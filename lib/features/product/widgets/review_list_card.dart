import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/utils/date_formatter.dart';
import 'package:oga_glow/features/product/models/review_model.dart';

class ReviewListCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewListCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  review.name.isNotEmpty ? review.name : 'Verified Customer',
                  style: AppTextStyles.heading2.copyWith(
                    color: colors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    size: 15.sp,
                    color: Colors.amber,
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            review.review.isNotEmpty
                ? review.review
                : 'No review details were provided.',
            style: AppTextStyles.body.copyWith(
              color: colors.textSecondary,
              height: 1.4,
            ),
          ),
          if (review.createdAt != null && review.createdAt!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              DateFormatter.formatPakistanDateTime(
                DateTime.tryParse(review.createdAt ?? '') ?? DateTime.now(),
              ),
              style: AppTextStyles.caption.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
