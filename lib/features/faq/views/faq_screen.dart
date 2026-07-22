import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/faq_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../controllers/faq_controller.dart';
import '../widgets/faq_card.dart';
import '../widgets/faq_category_header.dart';
import '../widgets/faq_search_bar.dart';
import '../widgets/empty_faq_widget.dart';

/// FAQ Screen.
///
/// Displays a searchable, categorized list of frequently asked questions.
/// Fully responsive, theme-aware, and follows the OgaGlow design system.
class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          FaqConstants.pageTitle,
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
              FadeSlideTransition(index: 0, child: _buildHeader(isDark)),
              SizedBox(height: 20.h),

              // ---- Introduction Text ----
              FadeSlideTransition(
                index: 1,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    FaqConstants.pageIntroduction,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14.sp,
                      color: isDark
                          ? Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.7)
                          : Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.6),
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // ---- Search Bar ----
              FadeSlideTransition(
                index: 2,
                child: FAQSearchBar(
                  onChanged: (query) => controller.filterFAQs(query),
                ),
              ),
              SizedBox(height: 20.h),

              // ---- FAQ Categories & Questions ----
              Obx(() {
                final categories = controller.filteredCategories;

                if (categories.isEmpty) {
                  return const EmptyFAQWidget();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < categories.length; i++) ...[
                      FadeSlideTransition(
                        index: i + 3,
                        child: FAQCategoryHeader(
                          category: categories[i],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      FadeSlideTransition(
                        index: i + 3,
                        child: Column(
                          children: [
                            for (final faq in categories[i].questions)
                              FAQCard(faq: faq),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ],
                );
              }),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header with an icon and page title.
  Widget _buildHeader(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(Get.context!).colorScheme.primary.withOpacity(0.12),
            Theme.of(Get.context!).colorScheme.primary.withOpacity(0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Theme.of(Get.context!).colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: isDark
                  ? Theme.of(Get.context!).colorScheme.primary.withOpacity(0.15)
                  : Theme.of(Get.context!).cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    Get.context!,
                  ).colorScheme.primary.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              Icons.help_outline_rounded,
              size: 30.sp,
              color: Theme.of(Get.context!).colorScheme.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            FaqConstants.pageTitle,
            style: AppTextStyles.heading1.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Theme.of(Get.context!).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            FaqConstants.pageSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

