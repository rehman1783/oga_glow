import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/forgot_password_controller.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/glow_background.dart';
import '../widgets/fade_slide_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app/routes/app_routes.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentGreen = isDark ? AppColors.primaryLight : AppColors.primary;

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
                  title: 'Reset Password',
                  subtitle: 'Enter your email to receive recovery instructions.',
                  showBackButton: true,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Guidance Card
                      FadeSlideTransition(
                        index: 1,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF102116) : AppColors.primary.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isDark ? const Color(0xFF264B30) : AppColors.primary.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF193622) : AppColors.primary.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.mark_email_read_outlined,
                                  color: accentGreen,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Text(
                                  "Enter your registered email address and we'll send you a link to reset your password.",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDark ? const Color(0xFFD6E8DA) : colors.textPrimary,
                                    height: 1.4,
                                    fontSize: 12.5.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Email input Card
                      FadeSlideTransition(
                        index: 2,
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
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email Address',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colors.textPrimary,
                                    fontSize: 13.5.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                TextFormField(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  validator: controller.validateEmail,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    hintStyle: TextStyle(
                                      color: isDark ? const Color(0xFF5B7863) : colors.textSecondary.withValues(alpha: 0.5),
                                      fontSize: 13.sp,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.mail_outline_rounded,
                                      color: isDark ? const Color(0xFF8BAE92) : AppColors.primary,
                                      size: 20,
                                    ),
                                    filled: true,
                                    fillColor: isDark ? const Color(0xFF0D1C12) : colors.inputBg,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(color: isDark ? const Color(0xFF223E28) : colors.border),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(color: isDark ? const Color(0xFF223E28) : colors.border),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(color: accentGreen, width: 1.8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(color: AppColors.error, width: 1.2),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(color: AppColors.error, width: 1.8),
                                    ),
                                  ),
                                  onFieldSubmitted: (_) => controller.sendForgotPasswordRequest(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Submit button
                      FadeSlideTransition(
                        index: 3,
                        child: Obx(
                          () => AuthSubmitButton(
                            text: 'Send Reset Link',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.sendForgotPasswordRequest,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Back to login
                      FadeSlideTransition(
                        index: 4,
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
                                  const TextSpan(text: 'Remember your password? '),
                                  TextSpan(
                                    text: 'Log in',
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
