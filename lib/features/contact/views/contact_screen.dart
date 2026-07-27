import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/contact_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import 'package:oga_glow/core/widgets/loading_widget.dart';
import '../controllers/contact_controller.dart';
import '../widgets/contact_form_card.dart';
import '../widgets/contact_info_section.dart';

/// Contact Us screen.
///
/// Displays office addresses, phone numbers, email, and social connectivity
/// links in a clean, premium Material 3 design.
class ContactScreen extends GetView<ContactController> {
  const ContactScreen({super.key});

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
          ContactConstants.heroTitle,
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            color: AppColors.of(context).textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.fetchContactInfo,
          color: AppColors.primary,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeSlideTransition(index: 0, child: _buildHeroSection(isDark)),
                SizedBox(height: 24.h),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const LoadingWidget();
                  }
                  if (controller.errorMessage.value.isNotEmpty) {
                    return Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        controller.errorMessage.value,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    );
                  }
                  return FadeSlideTransition(
                    index: 1,
                    child: ContactInfoSection(
                      contactInfo: controller.contactInfo.value,
                      onPhoneTap: controller.launchPhone,
                      onEmailTap: controller.launchEmail,
                      onUrlTap: controller.launchUrlString,
                    ),
                  );
                }),
                SizedBox(height: 24.h),
                FadeSlideTransition(index: 2, child: const ContactFormCard()),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the hero / header section with an icon, heading, and subtitle.
  Widget _buildHeroSection(bool isDark) {
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.12),
                AppColors.primaryLight.withValues(alpha: 0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              // Icon
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: AppColors.of(context).cardBackground,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.headset_mic_rounded,
                  size: 30.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 16.h),
              // Heading
              Text(
                ContactConstants.heroTitle,
                style: AppTextStyles.heading1.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.of(context).textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              // Subtitle
              Text(
                ContactConstants.heroSubtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.of(context).textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
