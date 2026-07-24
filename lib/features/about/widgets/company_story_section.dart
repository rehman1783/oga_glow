import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/about/widgets/about_section_title.dart';

/// Displays the company story section with rich text paragraphs.
///
/// Includes the "Our Story" title and multiple paragraphs
/// explaining who the company is, what they do, and why they started.
class CompanyStorySection extends StatelessWidget {
  const CompanyStorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AboutSectionTitle(
          icon: Icons.auto_stories_rounded,
          title: AboutConstants.storyTitle,
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.of(context).cardBackground,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.of(context).border),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _storyParagraph(context, AboutConstants.storyContent1),
              SizedBox(height: 16.h),
              _storyParagraph(context, AboutConstants.storyContent2),
              SizedBox(height: 16.h),
              _storyParagraph(context, AboutConstants.storyContent3),
              SizedBox(height: 16.h),
              _storyParagraph(context, AboutConstants.storyContent4),
            ],
          ),
        ),
      ],
    );
  }

  Widget _storyParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: AppTextStyles.body.copyWith(
        fontSize: 14.sp,
        color: AppColors.of(context).textSecondary,
        height: 1.6,
      ),
    );
  }
}
