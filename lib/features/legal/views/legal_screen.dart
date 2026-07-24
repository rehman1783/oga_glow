import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/legal_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../controllers/legal_controller.dart';
import '../widgets/legal_option_card.dart';

/// Legal & Compliance main listing screen.
///
/// Displays a professional header, short description, and three
/// cards for Terms of Service, Privacy Policy, and Return & Refund Policy.
class LegalScreen extends GetView<LegalController> {
  const LegalScreen({super.key});

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
          LegalConstants.pageTitle,
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            color: AppColors.of(context).textPrimary,
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
              // ---- Header Section ----
              FadeSlideTransition(index: 0, child: _buildHeader(isDark)),
              SizedBox(height: 24.h),

              // ---- Description ----
              FadeSlideTransition(
                index: 1,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Text(
                    LegalConstants.pageSubtitle,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.of(context).textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              // ---- Terms of Service Card ----
              FadeSlideTransition(
                index: 2,
                child: LegalOptionCard(
                  icon: Icons.description_rounded,
                  title: LegalConstants.termsTitle,
                  description: LegalConstants.termsSubtitle,
                  onTap: controller.openTermsOfService,
                ),
              ),
              SizedBox(height: 14.h),

              // ---- Privacy Policy Card ----
              FadeSlideTransition(
                index: 3,
                child: LegalOptionCard(
                  icon: Icons.shield_rounded,
                  title: LegalConstants.privacyTitle,
                  description: LegalConstants.privacySubtitle,
                  onTap: controller.openPrivacyPolicy,
                ),
              ),
              SizedBox(height: 14.h),

              // ---- Return & Refund Policy Card ----
              FadeSlideTransition(
                index: 4,
                child: LegalOptionCard(
                  icon: Icons.autorenew_rounded,
                  title: LegalConstants.refundTitle,
                  description: LegalConstants.refundSubtitle,
                  onTap: controller.openReturnRefundPolicy,
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header with an icon, title and subtitle.
  Widget _buildHeader(bool isDark) {
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.12),
                AppColors.primary.withValues(alpha: 0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
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
                  Icons.gavel_rounded,
                  size: 30.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                LegalConstants.pageTitle,
                style: AppTextStyles.heading1.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.of(context).textPrimary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
