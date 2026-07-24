import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/fade_slide_transition.dart';
import '../widgets/glow_background.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userEmail = (Get.arguments is String)
        ? Get.arguments as String
        : 'your email address';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlowBackground(
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthBrandHeader(
                  title: 'Verify Your Email',
                  subtitle: 'Check your inbox to complete registration.',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      FadeSlideTransition(
                        index: 1,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.1),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.mark_email_read_outlined,
                            size: 48,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeSlideTransition(
                        index: 2,
                        child: Text(
                          'Verification Link Sent!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.of(context).textPrimary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 12),
                      FadeSlideTransition(
                        index: 3,
                        child: Text(
                          'We have sent a verification email to:\n$userEmail\n\nPlease check your inbox and tap the link to verify your account before logging in.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: AppColors.of(context).textSecondary,
                                height: 1.5,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 36),
                      FadeSlideTransition(
                        index: 4,
                        child: Column(
                          children: [
                            AuthSubmitButton(
                              text: 'I Have Verified My Email',
                              isLoading: false,
                              onPressed: () {
                                debugPrint(
                                  '[DEBUG LOG] VerificationScreen: User confirmed verification, navigating to Login',
                                );
                                Get.offAllNamed(AppRoutes.login);
                              },
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                Get.offAllNamed(AppRoutes.login);
                              },
                              child: Text(
                                'Continue to Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
