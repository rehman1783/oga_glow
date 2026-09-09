import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_form_fields.dart';
import '../widgets/glow_background.dart';
import '../widgets/fade_slide_transition.dart';
import '../widgets/google_logo.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/routes/app_routes.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentGreen = isDark ? AppColors.primaryLight : AppColors.primary;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlowBackground(
        child: SafeArea(
          top: false, // Let header content draw under status bar
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthBrandHeader(
                  title: 'Create Account',
                  subtitle: 'Start your journey to healthy, glowing skin.',
                  showBackButton: true,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 14.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Animated Inline Error Alert Banner
                      Obx(() {
                        if (controller.errorMessage.value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          margin: EdgeInsets.only(bottom: 14.h),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: isDark ? 0.16 : 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.error.withValues(alpha: isDark ? 0.45 : 0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.error_outline_rounded,
                                color: AppColors.error,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Registration Issue',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.error,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      controller.errorMessage.value,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: colors.textPrimary,
                                        height: 1.3,
                                      ),
                                    ),
                                    if (controller.isAccountExists.value) ...[
                                      const SizedBox(height: 8),
                                      GestureDetector(
                                        onTap: () => Get.offNamed(AppRoutes.login),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: accentGreen,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            'Go to Login',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.close_rounded,
                                  size: 18,
                                  color: colors.textSecondary,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: controller.dismissError,
                              ),
                            ],
                          ),
                        );
                      }),

                      // Staggered Entrance 1: Credentials card
                      FadeSlideTransition(
                        index: 1,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF102015) : colors.panel,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: isDark ? const Color(0xFF22422A) : colors.border,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black.withValues(alpha: 0.35)
                                    : AppColors.black.withValues(alpha: 0.04),
                                blurRadius: isDark ? 20 : 18,
                                offset: const Offset(0, 8),
                              ),
                              if (isDark)
                                BoxShadow(
                                  color: AppColors.primaryLight.withValues(alpha: 0.06),
                                  blurRadius: 24,
                                  spreadRadius: 1,
                                ),
                            ],
                          ),
                          child: AuthTextFormFields(
                            isLogin: false,
                            emailController: controller.emailController,
                            passwordController: controller.passwordController,
                            confirmPasswordController: controller.confirmPasswordController,
                            nameController: controller.nameController,
                            showPasswordRequirements: true,
                          ),
                        ),
                      ),

                      SizedBox(height: 14.h),

                      // Staggered Entrance 2: Terms and policy agreement checkbox
                      FadeSlideTransition(
                        index: 2,
                        child: Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 22.w,
                                height: 22.h,
                                child: Checkbox(
                                  value: controller.agreedToTerms.value,
                                  activeColor: accentGreen,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: BorderSide(
                                    color: isDark ? const Color(0xFF2E5336) : colors.border,
                                    width: 1.2,
                                  ),
                                  onChanged: (val) {
                                    controller.agreedToTerms.value = val ?? false;
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isDark ? const Color(0xFF9EBEA5) : colors.textSecondary,
                                      height: 1.4,
                                      fontSize: 12.sp,
                                    ),
                                    children: [
                                      const TextSpan(text: 'I agree to the '),
                                      TextSpan(
                                        text: 'Terms of Service',
                                        style: TextStyle(
                                          color: accentGreen,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Get.toNamed(AppRoutes.termsOfService),
                                      ),
                                      const TextSpan(text: ' and '),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: accentGreen,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Get.toNamed(AppRoutes.privacyPolicy),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Staggered Entrance 3: Submit signup action
                      FadeSlideTransition(
                        index: 3,
                        child: Obx(
                          () => AuthSubmitButton(
                            text: 'Create Account',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.signup,
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Staggered Entrance 4: Divider text
                      FadeSlideTransition(
                        index: 4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: isDark ? const Color(0xFF223E28) : colors.border,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                'OR',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: isDark ? const Color(0xFF7E9E86) : colors.textSecondary,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: isDark ? const Color(0xFF223E28) : colors.border,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Staggered Entrance 5: Google Button
                      FadeSlideTransition(
                        index: 5,
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: isDark ? const Color(0xFF102015) : colors.cardBackground,
                              side: BorderSide(
                                color: isDark ? const Color(0xFF22422A) : colors.border,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const GoogleLogo(size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  'Sign up with Google',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.5.sp,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Staggered Entrance 6: Nav toggle to login
                      FadeSlideTransition(
                        index: 6,
                        child: Center(
                          child: TextButton(
                            onPressed: () => Get.offNamed(AppRoutes.login),
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: isDark ? const Color(0xFF9EBEA5) : colors.textSecondary,
                                  fontSize: 13.5.sp,
                                ),
                                children: [
                                  const TextSpan(text: "Already have an account? "),
                                  TextSpan(
                                    text: "Log in",
                                    style: TextStyle(
                                      color: accentGreen,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
