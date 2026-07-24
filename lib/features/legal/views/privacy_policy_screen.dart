import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/legal_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../widgets/policy_header.dart';
import '../widgets/policy_section.dart';
import '../widgets/policy_bullet.dart';

/// Privacy Policy screen.
///
/// Displays the full privacy policy content with proper typography,
/// section headings, bullet points, and theme-aware design.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          LegalConstants.privacyPageTitle,
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
                  icon: Icons.shield_rounded,
                  title: LegalConstants.privacyPageTitle,
                  lastUpdated: LegalConstants.privacyLastUpdated,
                  description: LegalConstants.privacyIntro,
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 1. What Data We Collect ----
              FadeSlideTransition(
                index: 1,
                child: PolicySection(
                  title: LegalConstants.privacyCollectTitle,
                ),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 2,
                child: Column(
                  children: [
                    PolicyBullet(
                      text: LegalConstants.privacyCollectContent1,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyCollectContent2,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyCollectContent3,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyCollectContent4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 2. How We Use Your Data ----
              FadeSlideTransition(
                index: 3,
                child: PolicySection(
                  title: LegalConstants.privacyUseTitle,
                ),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 4,
                child: Column(
                  children: [
                    PolicyBullet(
                      text: LegalConstants.privacyUseContent1,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyUseContent2,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyUseContent3,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyUseContent4,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyUseContent5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 3. Cookies ----
              FadeSlideTransition(
                index: 5,
                child: PolicySection(
                  title: LegalConstants.privacyCookiesTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 6,
                child: _buildParagraph(LegalConstants.privacyCookiesContent),
              ),
              SizedBox(height: 24.h),

              // ---- 4. Third-Party Services ----
              FadeSlideTransition(
                index: 7,
                child: PolicySection(
                  title: LegalConstants.privacyThirdPartyTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 8,
                child: _buildParagraph(
                  LegalConstants.privacyThirdPartyContent,
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 5. Your Rights ----
              FadeSlideTransition(
                index: 9,
                child: PolicySection(
                  title: LegalConstants.privacyRightsTitle,
                ),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 10,
                child: Column(
                  children: [
                    PolicyBullet(
                      text: LegalConstants.privacyRightsContent1,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyRightsContent2,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyRightsContent3,
                    ),
                    PolicyBullet(
                      text: LegalConstants.privacyRightsContent4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ---- 6. Contact Information ----
              FadeSlideTransition(
                index: 11,
                child: PolicySection(
                  title: LegalConstants.privacyContactTitle,
                ),
              ),
              SizedBox(height: 4.h),
              FadeSlideTransition(
                index: 12,
                child: _buildParagraph(
                  LegalConstants.privacyContactContent,
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

