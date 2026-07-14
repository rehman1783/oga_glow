import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_form_fields.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/routes/app_routes.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const AuthBrandHeader(),
              const SizedBox(height: 18),
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
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
              const SizedBox(height: 14),

              Text(
                'By continuing, you agree to our Terms & Privacy Policy.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 16),

              Obx(
                () => AuthSubmitButton(
                  text: 'Create account',
                  isLoading: controller.isLoading.value,
                  onPressed: controller.signup,
                ),
              ),

              const SizedBox(height: 18),

              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  child: Text(
                    "Already have an account? Log in",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
