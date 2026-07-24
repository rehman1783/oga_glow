import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_form_fields.dart';
import '../widgets/glow_background.dart';
import '../widgets/fade_slide_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/routes/app_routes.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

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
                  title: 'Create Account',
                  subtitle: 'Start your journey to healthy, glowing skin.',
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                            isLogin: false,
                            emailController: controller.emailController,
                            passwordController: controller.passwordController,
                            nameController: controller.nameController,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),

                      // Staggered Entrance 2: Terms and policy text
                      FadeSlideTransition(
                        index: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            'By continuing, you agree to our Terms & Privacy Policy.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.of(context).textSecondary,
                                  height: 1.4,
                                ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

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

                      const SizedBox(height: 24),

                      // Staggered Entrance 4: Nav toggle to login
                      FadeSlideTransition(
                        index: 4,
                        child: Center(
                          child: TextButton(
                            onPressed: () => Get.toNamed(AppRoutes.login),
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.of(context).textSecondary,
                                    ),
                                children: const [
                                  TextSpan(text: "Already have an account? "),
                                  TextSpan(
                                    text: "Log in",
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
