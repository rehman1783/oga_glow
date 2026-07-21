import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/contact_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../controllers/contact_controller.dart';
import '../widgets/contact_info_card.dart';
import '../widgets/contact_row.dart';
import '../widgets/contact_section_title.dart';
import '../widgets/office_card.dart';

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
              FadeSlideTransition(index: 0, child: _buildHeroSection(isDark)),
              SizedBox(height: 24.h),

              // ---- Office Information Section ----
              FadeSlideTransition(
                index: 1,
                child: ContactSectionTitle(
                  icon: Icons.business_rounded,
                  title: 'Our Offices',
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 2,
                child: ContactInfoCard(
                  child: Column(
                    children: [
                      OfficeCard(
                        title: ContactConstants.headOfficeTitle,
                        city: ContactConstants.headOfficeCity,
                        address: ContactConstants.headOfficeAddress,
                      ),
                      SizedBox(height: 12.h),
                      OfficeCard(
                        title: ContactConstants.subOfficeTitle,
                        city: ContactConstants.subOfficeCity,
                        address: ContactConstants.subOfficeAddress,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // ---- Contact Numbers Section ----
              FadeSlideTransition(
                index: 3,
                child: ContactSectionTitle(
                  icon: Icons.phone_rounded,
                  title: 'Phone Numbers',
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 4,
                child: ContactInfoCard(
                  child: Column(
                    children: [
                      ContactRow(
                        icon: Icons.call_rounded,
                        label: ContactConstants.phoneLabel1,
                        value: ContactConstants.phoneNumber1,
                        onTap: () =>
                            controller.launchPhone(ContactConstants.phoneDial1),
                      ),
                      Divider(
                        height: 1,
                        color: AppColors.border.withOpacity(0.3),
                      ),
                      ContactRow(
                        icon: Icons.call_rounded,
                        label: ContactConstants.phoneLabel2,
                        value: ContactConstants.phoneNumber2,
                        onTap: () =>
                            controller.launchPhone(ContactConstants.phoneDial2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // ---- Email Section ----
              FadeSlideTransition(
                index: 5,
                child: ContactSectionTitle(
                  icon: Icons.email_rounded,
                  title: 'Email',
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 6,
                child: ContactInfoCard(
                  child: ContactRow(
                    icon: Icons.email_outlined,
                    label: ContactConstants.emailLabel,
                    value: ContactConstants.emailAddress,
                    onTap: () =>
                        controller.launchEmail(ContactConstants.emailUri),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // ---- Global Connectivity Section ----
              FadeSlideTransition(
                index: 7,
                child: ContactSectionTitle(
                  icon: Icons.public_rounded,
                  title: ContactConstants.connectivityTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 8,
                child: ContactInfoCard(
                  child: Column(
                    children: [
                      ContactRow(
                        icon: Icons.language_rounded,
                        label: ContactConstants.websiteLabel,
                        value: ContactConstants.websiteUrl,
                        onTap: () => controller.launchUrlString(
                          ContactConstants.websiteUrl,
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: AppColors.border.withOpacity(0.3),
                      ),
                      ContactRow(
                        icon: Icons.facebook_rounded,
                        label: ContactConstants.facebookLabel,
                        value: ContactConstants.facebookUrl,
                        onTap: () => controller.launchUrlString(
                          ContactConstants.facebookUrl,
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: AppColors.border.withOpacity(0.3),
                      ),
                      // Instagram (no native icon, using photo_camera)
                      ContactRow(
                        icon: Icons.camera_alt_rounded,
                        label: ContactConstants.instagramLabel,
                        value: ContactConstants.instagramUrl,
                        onTap: () => controller.launchUrlString(
                          ContactConstants.instagramUrl,
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: AppColors.border.withOpacity(0.3),
                      ),
                      // LinkedIn
                      ContactRow(
                        icon: Icons.work_outline_rounded,
                        label: ContactConstants.linkedInLabel,
                        value: ContactConstants.linkedInUrl,
                        onTap: () => controller.launchUrlString(
                          ContactConstants.linkedInUrl,
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: AppColors.border.withOpacity(0.3),
                      ),
                      // WhatsApp
                      ContactRow(
                        icon: Icons.chat_rounded,
                        label: ContactConstants.whatsAppLabel,
                        value: ContactConstants.whatsAppUrl,
                        onTap: () => controller.launchUrlString(
                          ContactConstants.whatsAppUrl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the hero / header section with an icon, heading, and subtitle.
  Widget _buildHeroSection(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.12),
            AppColors.primaryLight.withOpacity(0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          // Icon
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
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
              color: Theme.of(Get.context!).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          // Subtitle
          Text(
            ContactConstants.heroSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
