import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Displays the company story section with Mission & Vision cards.
class CompanyStorySection extends StatelessWidget {
  const CompanyStorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

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
                Icons.auto_stories_rounded,
                color: AppColors.primary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              AboutConstants.storyTitle,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Story Details Container
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: colors.border.withValues(alpha: 0.6)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _storyParagraph(context, AboutConstants.storyContent1),
              SizedBox(height: 12.h),
              _storyParagraph(context, AboutConstants.storyContent2),
              SizedBox(height: 16.h),

              // Highlight Quote Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.1),
                      AppColors.primaryLight.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border(
                    left: BorderSide(color: AppColors.primary, width: 4.w),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.format_quote_rounded,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Every product in our collection is crafted with passion, quality, and your natural wellness in mind.',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 12.5.sp,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),

        // Mission & Vision Dual Cards
        Row(
          children: [
            Expanded(
              child: _infoCard(
                context,
                title: AboutConstants.missionTitle,
                content: AboutConstants.missionContent,
                icon: Icons.track_changes_rounded,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _infoCard(
                context,
                title: AboutConstants.visionTitle,
                content: AboutConstants.visionContent,
                icon: Icons.visibility_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _storyParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: AppTextStyles.body.copyWith(
        fontSize: 13.sp,
        color: AppColors.of(context).textSecondary,
        height: 1.55,
      ),
    );
  }

  Widget _infoCard(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
  }) {
    final colors = AppColors.of(context);
    return Container(
      padding: EdgeInsets.all(14.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 18.sp),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(
              fontSize: 11.5.sp,
              color: colors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
