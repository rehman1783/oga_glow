import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/legal_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../widgets/policy_header.dart';
import '../widgets/policy_section.dart';
import '../widgets/policy_bullet.dart';

/// Return & Refund Policy screen.
///
/// Displays the full return and refund policy content with proper
/// typography, section headings, bullet points, and theme-aware design.
class ReturnRefundPolicyScreen extends StatelessWidget {
  const ReturnRefundPolicyScreen({super.key});

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
          LegalConstants.refundPageTitle,
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
              // ---- Header ----
              FadeSlideTransition(
                index: 0,
                child: PolicyHeader(
                  icon: Icons.autorenew_rounded,
                  title: LegalConstants.refundPageTitle,
                  lastUpdated: LegalConstants.refundLastUpdated,
                  description: LegalConstants.refundIntro,
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 1. Return Window ----
              FadeSlideTransition(
                index: 1,
                child: PolicySection(
                  title: LegalConstants.refundWindowTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 2,
                child: _buildParagraph(LegalConstants.refundWindowContent),
              ),
              SizedBox(height: 24.h),

              // ---- 2. Eligible Products ----
              FadeSlideTransition(
                index: 3,
                child: PolicySection(
                  title: LegalConstants.refundEligibleTitle,
                ),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 4,
                child: Column(
                  children: [
                    PolicyBullet(
                      text: LegalConstants.refundEligibleContent1,
                    ),
                    PolicyBullet(
                      text: LegalConstants.refundEligibleContent2,
                    ),
                    PolicyBullet(
                      text: LegalConstants.refundEligibleContent3,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 3. Non-Returnable Products ----
              FadeSlideTransition(
                index: 5,
                child: PolicySection(
                  title: LegalConstants.refundNonEligibleTitle,
                ),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 6,
                child: Column(
                  children: [
                    PolicyBullet(
                      text: LegalConstants.refundNonEligibleContent1,
                    ),
                    PolicyBullet(
                      text: LegalConstants.refundNonEligibleContent2,
                    ),
                    PolicyBullet(
                      text: LegalConstants.refundNonEligibleContent3,
                    ),
                    PolicyBullet(
                      text: LegalConstants.refundNonEligibleContent4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 4. Refund Process ----
              FadeSlideTransition(
                index: 7,
                child: PolicySection(
                  title: LegalConstants.refundProcessTitle,
                ),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 8,
                child: Column(
                  children: [
                    PolicyBullet(
                      text: LegalConstants.refundProcessContent1,
                    ),
                    PolicyBullet(
                      text: LegalConstants.refundProcessContent2,
                    ),
                    PolicyBullet(
                      text: LegalConstants.refundProcessContent3,
                    ),
                    PolicyBullet(
                      text: LegalConstants.refundProcessContent4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 5. Return Shipping ----
              FadeSlideTransition(
                index: 9,
                child: PolicySection(
                  title: LegalConstants.refundShippingTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 10,
                child: _buildParagraph(
                  LegalConstants.refundShippingContent,
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 6. Contact Information ----
              FadeSlideTransition(
                index: 11,
                child: PolicySection(
                  title: LegalConstants.refundContactTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 12,
                child: _buildParagraph(
                  LegalConstants.refundContactContent,
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a paragraph of text.
  Widget _buildParagraph(String text) {
    final isDark = Get.context != null &&
        Theme.of(Get.context!).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          fontSize: 14.sp,
          color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
          height: 1.6,
        ),
      ),
    );
  }
}

