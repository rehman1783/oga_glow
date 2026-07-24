import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/legal_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../widgets/policy_header.dart';
import '../widgets/policy_section.dart';
import '../widgets/policy_bullet.dart';

/// Terms of Service screen.
///
/// Displays the full terms of service content with proper typography,
/// section headings, bullet points, and theme-aware design.
class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
          LegalConstants.tosTitle,
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
              // ---- Header ----
              FadeSlideTransition(
                index: 0,
                child: PolicyHeader(
                  icon: Icons.description_rounded,
                  title: LegalConstants.tosTitle,
                  lastUpdated: LegalConstants.tosLastUpdated,
                  description: LegalConstants.tosIntro,
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 1. Website Usage Rules ----
              FadeSlideTransition(
                index: 1,
                child: PolicySection(title: LegalConstants.tosUsageTitle),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 2,
                child: _buildParagraph(LegalConstants.tosUsageContent),
              ),
              SizedBox(height: 24.h),

              // ---- 2. User Responsibilities ----
              FadeSlideTransition(
                index: 3,
                child: PolicySection(
                  title: LegalConstants.tosResponsibilityTitle,
                ),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 4,
                child: Column(
                  children: [
                    PolicyBullet(
                      text: LegalConstants.tosResponsibilityContent1,
                    ),
                    PolicyBullet(
                      text: LegalConstants.tosResponsibilityContent2,
                    ),
                    PolicyBullet(
                      text: LegalConstants.tosResponsibilityContent3,
                    ),
                    PolicyBullet(
                      text: LegalConstants.tosResponsibilityContent4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 3. Orders ----
              FadeSlideTransition(
                index: 5,
                child: PolicySection(title: LegalConstants.tosOrdersTitle),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 6,
                child: _buildParagraph(LegalConstants.tosOrdersContent),
              ),
              SizedBox(height: 24.h),

              // ---- 4. Payments ----
              FadeSlideTransition(
                index: 7,
                child: PolicySection(title: LegalConstants.tosPaymentsTitle),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 8,
                child: _buildParagraph(LegalConstants.tosPaymentsContent),
              ),
              SizedBox(height: 24.h),

              // ---- 5. Intellectual Property ----
              FadeSlideTransition(
                index: 9,
                child: PolicySection(
                  title: LegalConstants.tosIntellectualPropertyTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 10,
                child: _buildParagraph(
                  LegalConstants.tosIntellectualPropertyContent,
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 6. Limitation of Liability ----
              FadeSlideTransition(
                index: 11,
                child: PolicySection(
                  title: LegalConstants.tosLiabilityTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 12,
                child: _buildParagraph(LegalConstants.tosLiabilityContent),
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
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Builder(
        builder: (context) {
          return Text(
            text,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              color: AppColors.of(context).textSecondary,
              height: 1.6,
            ),
          );
        },
      ),
    );
  }
}

