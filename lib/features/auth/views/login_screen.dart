import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_form_fields.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/routes/app_routes.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const AuthBrandHeader(title: 'Login'),
              const SizedBox(height: 24),
              AuthTextFormFields(
                isLogin: true,
                emailController: controller.emailController,
                passwordController: controller.passwordController,
                nameController: null,
              ),
              const SizedBox(height: 14),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Obx(
                () => AuthSubmitButton(
                  text: 'Login',
                  isLoading: controller.isLoading.value,
                  onPressed: controller.login,
                ),
              ),

              const SizedBox(height: 18),

              // Divider text
              Row(
                children: [
                  Expanded(
                    child: Divider(color: AppColors.border, thickness: 1),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'OR',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Divider(color: AppColors.border, thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    side: BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Continue with Google',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Switch to signup
              Center(
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.signup),
                  child: Text(
                    "Don't have an account? Sign up",
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
