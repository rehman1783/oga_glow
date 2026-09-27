import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../controllers/about_controller.dart';
import '../widgets/about_body_image_card.dart';
import '../widgets/about_empty_widget.dart';
import '../widgets/about_error_widget.dart';
import '../widgets/about_header.dart';
import '../widgets/about_highlight_card.dart';
import '../widgets/about_shimmer_loading.dart';
import '../widgets/about_values_section.dart';
import '../widgets/company_story_section.dart';
import '../widgets/cta_button_section.dart';
import '../widgets/reviews_section.dart';

/// About Us screen.
///
/// Fully API-driven & feature-rich About Us page that showcases hero banner,
/// company story & mission, values, call-to-action buttons, customer feedback,
/// and FAQ items.
class AboutScreen extends GetView<AboutController> {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          AboutConstants.heroTitle,
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded, size: 22.sp, color: AppColors.primary),
            tooltip: 'Refresh Page',
            onPressed: () => controller.fetchAboutPageData(forceRefresh: true),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          // 1. Loading State
          if (controller.isLoading.value) {
            return const AboutShimmerLoading();
          }

          // 2. Error State
          if (controller.isError.value) {
            return AboutErrorWidget(
              message: controller.errorMessage.value,
              onRetry: controller.fetchAboutUs,
            );
          }

          final data = controller.aboutData.value;

          // 3. Empty State
          if (data == null || controller.isEmptyState) {
            return const AboutEmptyWidget();
          }

          final banner = data.banner;

          return RefreshIndicator(
            onRefresh: () => controller.fetchAboutPageData(forceRefresh: true),
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- 1. Hero / Header Section ----
                  FadeSlideTransition(
                    index: 0,
                    child: AboutHeader(
                      imageUrl: banner?.image,
                      paragraph: banner?.paragraph,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ---- 2. Dynamic Highlight Cards (API Driven) ----
                  if (banner?.card1?.trim().isNotEmpty == true)
                    FadeSlideTransition(
                      index: 1,
                      child: AboutHighlightCard(
                        title: banner!.card1!,
                        icon: Icons.star_rounded,
                      ),
                    ),
                  if (banner?.card2?.trim().isNotEmpty == true)
                    FadeSlideTransition(
                      index: 2,
                      child: AboutHighlightCard(
                        title: banner!.card2!,
                        icon: Icons.verified_user_rounded,
                      ),
                    ),
                  if (banner?.card3?.trim().isNotEmpty == true)
                    FadeSlideTransition(
                      index: 3,
                      child: AboutHighlightCard(
                        title: banner!.card3!,
                        icon: Icons.workspace_premium_rounded,
                      ),
                    ),
                  if (banner?.card1?.isNotEmpty == true ||
                      banner?.card2?.isNotEmpty == true ||
                      banner?.card3?.isNotEmpty == true)
                    SizedBox(height: 16.h),

                  // ---- 3. Company Story & Mission / Vision ----
                  const FadeSlideTransition(
                    index: 4,
                    child: CompanyStorySection(),
                  ),
                  SizedBox(height: 24.h),

                  // ---- 4. Why Choose Us & Company Values ----
                  const FadeSlideTransition(
                    index: 5,
                    child: AboutValuesSection(),
                  ),
                  SizedBox(height: 24.h),

                  // ---- 5. Single Body Image Banner (Only 2 images total on About screen: 1 Header + 1 Body) ----
                  if (data.firstImage?.trim().isNotEmpty == true) ...[
                    FadeSlideTransition(
                      index: 6,
                      child: AboutBodyImageCard(
                        imageUrl: data.firstImage,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 14.h),
                  ] else if (data.secondImage?.trim().isNotEmpty == true) ...[
                    FadeSlideTransition(
                      index: 6,
                      child: AboutBodyImageCard(
                        imageUrl: data.secondImage,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 14.h),
                  ] else if (data.faqImage?.trim().isNotEmpty == true) ...[
                    FadeSlideTransition(
                      index: 6,
                      child: AboutBodyImageCard(
                        imageUrl: data.faqImage,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 14.h),
                  ],

                  // ---- 7. Call-To-Action & Direct Support Section ----
                  FadeSlideTransition(
                    index: 8,
                    child: CTAButtonSection(
                      leftButtonTitle: banner?.leftButton,
                      rightButtonTitle: banner?.rightButton,
                      phone: controller.contactInfo.value.primaryPhone,
                      email: controller.contactInfo.value.primaryEmail,
                      onShopNow: controller.shopNow,
                      onContactUs: controller.contactUs,
                      onTalkToExperts: controller.talkToExperts,
                      onViewProducts: controller.viewProducts,
                      onPhone: () => controller.launchPhone(),
                      onEmail: () => controller.launchEmail(),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ---- 8. Customer Reviews / Feedback Section ----
                  const FadeSlideTransition(
                    index: 9,
                    child: ReviewsSection(),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

