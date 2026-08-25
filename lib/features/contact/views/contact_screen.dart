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
/// Displays office addresses, phone numbers, email, WhatsApp, and social connectivity
/// links in a clean, luxury skincare brand design.
class ContactScreen extends GetView<ContactController> {
  const ContactScreen({super.key});

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
          ContactConstants.heroTitle,
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.of(context).textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.fetchContactInfo,
          color: AppColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeSlideTransition(index: 0, child: _buildHeroSection(context)),
                SizedBox(height: 20.h),

                // Live Contact Info from API
                Obx(() {
                  if (controller.isLoading.value && controller.contactInfo.value.allOffices.isEmpty) {
                    return const LoadingWidget();
                  }

                  return FadeSlideTransition(
                    index: 1,
                    child: ContactInfoSection(
                      contactInfo: controller.contactInfo.value,
                      onPhoneTap: controller.launchPhone,
                      onEmailTap: controller.launchEmail,
                      onUrlTap: controller.launchUrlString,
                      onWhatsAppTap: controller.launchWhatsApp,
                      onWhatsAppNumberTap: controller.launchWhatsApp,
                      onCopyTap: controller.copyToClipboard,
                    ),
                  );
                }),

                SizedBox(height: 24.h),

                // Inquiry Form Card
                FadeSlideTransition(index: 2, child: const ContactFormCard()),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the hero / header section with luxury brand banner and quick support badge.
  Widget _buildHeroSection(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.14),
            AppColors.primaryLight.withValues(alpha: 0.08),
            colors.cardBackground,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row: Brand icon + Status chip
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.headset_mic_rounded,
                  size: 26.sp,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7.w,
                      height: 7.w,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Live Support Active',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Heading
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Get in Touch with Us',
              style: AppTextStyles.heading1.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
              ),
            ),
          ),
          SizedBox(height: 6.h),

          // Subtitle
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Have questions about our skincare routine or your orders? Our dedicated wellness team is here to assist you.',
              style: AppTextStyles.body.copyWith(
                fontSize: 13.sp,
                color: colors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

