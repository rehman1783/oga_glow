import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../controllers/about_controller.dart';
import '../widgets/about_header.dart';
import '../widgets/about_section_title.dart';
import '../widgets/company_story_section.dart';
import '../widgets/cta_button_section.dart';
import '../widgets/mission_vision_card.dart';
import '../widgets/statistic_card.dart';
import '../widgets/values_card.dart';
import '../widgets/why_choose_us_card.dart';

/// About Us screen.
///
/// A premium, fully responsive About Us page that showcases the company
/// story, mission, vision, values, statistics, and call-to-action buttons
/// in a clean Material 3 design.
class AboutScreen extends GetView<AboutController> {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          AboutConstants.heroTitle,
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Hero / Header Section ----
              FadeSlideTransition(index: 0, child: const AboutHeader()),
              SizedBox(height: 24.h),

              // ---- Our Story Section ----
              FadeSlideTransition(index: 1, child: const CompanyStorySection()),
              SizedBox(height: 24.h),

              // ---- Our Mission Section ----
              FadeSlideTransition(
                index: 2,
                child: const AboutSectionTitle(
                  icon: Icons.flag_rounded,
                  title: AboutConstants.missionTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 3,
                child: MissionVisionCard(
                  icon: Icons.flag_rounded,
                  title: AboutConstants.missionTitle,
                  description: AboutConstants.missionContent,
                ),
              ),
              SizedBox(height: 24.h),

              // ---- Our Vision Section ----
              FadeSlideTransition(
                index: 4,
                child: const AboutSectionTitle(
                  icon: Icons.travel_explore_rounded,
                  title: AboutConstants.visionTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 5,
                child: MissionVisionCard(
                  icon: Icons.travel_explore_rounded,
                  title: AboutConstants.visionTitle,
                  description: AboutConstants.visionContent,
                ),
              ),
              SizedBox(height: 24.h),

              // ---- Why Choose Us Section ----
              FadeSlideTransition(
                index: 6,
                child: const AboutSectionTitle(
                  icon: Icons.thumb_up_alt_rounded,
                  title: AboutConstants.whyChooseUsTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(index: 7, child: _buildWhyChooseUsGrid()),
              SizedBox(height: 24.h),

              // ---- Company Values Section ----
              FadeSlideTransition(
                index: 8,
                child: const AboutSectionTitle(
                  icon: Icons.diamond_rounded,
                  title: AboutConstants.valuesTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(index: 9, child: _buildValuesGrid()),
              SizedBox(height: 24.h),

              // ---- Company Statistics Section ----
              FadeSlideTransition(
                index: 10,
                child: const AboutSectionTitle(
                  icon: Icons.bar_chart_rounded,
                  title: AboutConstants.statisticsTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(index: 11, child: _buildStatisticsGrid()),
              SizedBox(height: 24.h),

              // ---- CTA Section ----
              FadeSlideTransition(
                index: 12,
                child: CTAButtonSection(
                  onShopNow: controller.shopNow,
                  onContactUs: controller.contactUs,
                  onTalkToExperts: controller.talkToExperts,
                  onViewProducts: controller.viewProducts,
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the "Why Choose Us" grid with 2 columns.
  Widget _buildWhyChooseUsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 1.0,
      ),
      itemCount: AboutConstants.whyChooseUsFeatures.length,
      itemBuilder: (context, index) {
        final feature = AboutConstants.whyChooseUsFeatures[index];
        return WhyChooseUsCard(
          title: feature['title']!,
          description: feature['description']!,
          iconName: feature['icon']!,
        );
      },
    );
  }

  /// Builds the company values list.
  Widget _buildValuesGrid() {
    return Column(
      children: AboutConstants.companyValues.map((value) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: ValuesCard(
            title: value['title']!,
            description: value['description']!,
            iconName: value['icon']!,
          ),
        );
      }).toList(),
    );
  }

  /// Builds the statistics grid with 2 columns.
  Widget _buildStatisticsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.9,
      ),
      itemCount: AboutConstants.statistics.length,
      itemBuilder: (context, index) {
        final stat = AboutConstants.statistics[index];
        return StatisticCard(
          value: stat['value'] as int,
          suffix: stat['suffix'] as String,
          label: stat['label'] as String,
          iconName: stat['icon'] as String,
        );
      },
    );
  }
}
