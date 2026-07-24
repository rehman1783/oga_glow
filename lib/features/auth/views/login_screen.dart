import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_form_fields.dart';
import '../widgets/glow_background.dart';
import '../widgets/fade_slide_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/routes/app_routes.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  title: 'Welcome Back',
                  subtitle: 'Sign in to access your glowing routine.',
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Staggered Entrance 1: Credentials card
                      FadeSlideTransition(
                        index: 1,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.of(context).panel,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppColors.of(context).border,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: AuthTextFormFields(
                            isLogin: true,
                            emailController: controller.emailController,
                            passwordController: controller.passwordController,
                            nameController: null,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Staggered Entrance 2: Forgot password link
                      FadeSlideTransition(
                        index: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: controller.navigateToForgotPassword,
                            child: Text(
                              'Forgot password?',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Staggered Entrance 3: Submit login action
                      FadeSlideTransition(
                        index: 3,
                        child: Obx(
                          () => AuthSubmitButton(
                            text: 'Login',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.login,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Staggered Entrance 4: Divider text
                      FadeSlideTransition(
                        index: 4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.of(context).border,
                                thickness: 1,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'OR',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.of(context).textSecondary,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Divider(
                                color: AppColors.of(context).border,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Staggered Entrance 5: Google Button
                      FadeSlideTransition(
                        index: 5,
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.of(context).cardBackground,
                              side: BorderSide(
                                color: AppColors.of(context).border,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.g_mobiledata,
                                  color: Colors.redAccent,
                                  size: 32,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Continue with Google',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: AppColors.of(context).textPrimary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Staggered Entrance 6: Nav toggle to sign up
                      FadeSlideTransition(
                        index: 6,
                        child: Center(
                          child: TextButton(
                            onPressed: () => Get.toNamed(AppRoutes.signup),
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.of(context).textSecondary),
                                children: const [
                                  TextSpan(text: "Don't have an account? "),
                                  TextSpan(
                                    text: "Sign up",
                                    style: TextStyle(
                                      color: AppColors.primary,
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
