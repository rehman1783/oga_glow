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
import '../widgets/about_faq_item.dart';
import '../widgets/about_header.dart';
import '../widgets/about_highlight_card.dart';
import '../widgets/about_section_title.dart';
import '../widgets/about_shimmer_loading.dart';
import '../widgets/cta_button_section.dart';

/// About Us screen.
///
/// Fully API-driven About Us page that showcases the company hero banner,
/// highlight cards, call-to-action buttons, body images, and dynamic FAQ items.
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
            color: AppColors.of(context).textPrimary,
          ),
        ),
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
            onRefresh: controller.fetchAboutUs,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Hero / Header Section ----
                  FadeSlideTransition(
                    index: 0,
                    child: AboutHeader(
                      imageUrl: banner?.image,
                      paragraph: banner?.paragraph,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ---- Highlight Cards (card1, card2, card3) ----
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
                    SizedBox(height: 12.h),

                  // ---- First Body Image ----
                  if (data.firstImage?.trim().isNotEmpty == true) ...[
                    FadeSlideTransition(
                      index: 4,
                      child: AboutBodyImageCard(
                        imageUrl: data.firstImage,
                        height: 200.h,
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],

                  // ---- Second Body Image ----
                  if (data.secondImage?.trim().isNotEmpty == true) ...[
                    FadeSlideTransition(
                      index: 5,
                      child: AboutBodyImageCard(
                        imageUrl: data.secondImage,
                        height: 200.h,
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // ---- Call-To-Action Section ----
                  FadeSlideTransition(
                    index: 6,
                    child: CTAButtonSection(
                      leftButtonTitle: banner?.leftButton,
                      rightButtonTitle: banner?.rightButton,
                      onShopNow: controller.shopNow,
                      onContactUs: controller.contactUs,
                      onTalkToExperts: controller.talkToExperts,
                      onViewProducts: controller.viewProducts,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ---- FAQ Section ----
                  if (data.faqImage?.trim().isNotEmpty == true ||
                      !controller.isFaqEmpty) ...[
                    FadeSlideTransition(
                      index: 7,
                      child: const AboutSectionTitle(
                        icon: Icons.help_center_rounded,
                        title: 'Frequently Asked Questions',
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // FaqImage Section Banner
                    if (data.faqImage?.trim().isNotEmpty == true)
                      FadeSlideTransition(
                        index: 8,
                        child: AboutBodyImageCard(
                          imageUrl: data.faqImage,
                          height: 160.h,
                        ),
                      ),

                    // Dynamic FAQ items list
                    if (!controller.isFaqEmpty)
                      ...List.generate(
                        data.faq!.length,
                        (index) {
                          final faqItem = data.faq![index];
                          return FadeSlideTransition(
                            index: 9 + index,
                            child: AboutFaqItem(
                              question: faqItem.question ?? '',
                              answer: faqItem.answer ?? '',
                            ),
                          );
                        },
                      )
                    else
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const AboutEmptyWidget(
                          title: 'No FAQ Items',
                          message: 'No FAQs are available right now.',
                        ),
                      ),
                  ],

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
