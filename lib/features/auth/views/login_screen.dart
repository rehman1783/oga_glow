import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_form_fields.dart';
import '../widgets/glow_background.dart';
import '../widgets/fade_slide_transition.dart';
import '../widgets/google_logo.dart';
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
                            color: AppColors.error.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.error.withValues(alpha: 0.3),
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
                                      'Login Issue',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.error,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      controller.errorMessage.value,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.of(context).textPrimary,
                                        height: 1.3,
                                      ),
                                    ),
                                    if (controller.isAccountNotFound.value) ...[
                                      const SizedBox(height: 8),
                                      GestureDetector(
                                        onTap: () => Get.offNamed(AppRoutes.signup),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            'Create New Account',
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
                                  color: AppColors.of(context).textSecondary,
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
                            color: AppColors.of(context).panel,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: AppColors.of(context).border,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.04),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
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

                      SizedBox(height: 10.h),

                      // Staggered Entrance 2: Remember Me & Forgot Password Row
                      FadeSlideTransition(
                        index: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 22.w,
                                  height: 22.h,
                                  child: Checkbox(
                                    value: true,
                                    activeColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    side: BorderSide(
                                      color: AppColors.of(context).border,
                                      width: 1.2,
                                    ),
                                    onChanged: (val) {},
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Remember me',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.of(context).textSecondary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.5.sp,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: controller.navigateToForgotPassword,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Forgot password?',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.5.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

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

                      SizedBox(height: 20.h),

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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                'OR',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.of(context).textSecondary,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColors.of(context).border,
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
                              backgroundColor: AppColors.of(context).cardBackground,
                              side: BorderSide(
                                color: AppColors.of(context).border,
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
                                  'Continue with Google',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.5.sp,
                                    color: AppColors.of(context).textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Staggered Entrance 6: Nav toggle to sign up
                      FadeSlideTransition(
                        index: 6,
                        child: Center(
                          child: TextButton(
                            onPressed: () => Get.offNamed(AppRoutes.signup),
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.of(context).textSecondary,
                                  fontSize: 13.5.sp,
                                ),
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
