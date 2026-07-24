import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/forgot_password_controller.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/glow_background.dart';
import '../widgets/fade_slide_transition.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../app/routes/app_routes.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  subtitle: 'Enter your email to receive a reset link.',
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Obx(
                    () => controller.currentStep.value == 0
                        ? _buildEmailStep(context)
                        : _buildOtpStep(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Step 1: Email entry
  // ------------------------------------------------------------------
  Widget _buildEmailStep(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),

        FadeSlideTransition(
          index: 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.panel,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: colors.border,
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
                      prefixIcon: const Icon(Icons.mail_outline),
                      filled: true,
                      fillColor: colors.inputBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: colors.border,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: colors.border,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.8,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.error,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: AppColors.error,
                          width: 1.8,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (_) =>
                        controller.sendForgotPasswordRequest(),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 24.h),

        // Submit button
        FadeSlideTransition(
          index: 2,
          child: SizedBox(
            width: double.infinity,
            height: 52.h,
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.sendForgotPasswordRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                  shadowColor: AppColors.primary.withValues(alpha: 0.25),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: controller.isLoading.value
                      ? SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.white,
                          ),
                        )
                      : Text(
                          'Send Reset Link',
                          style: AppTextStyles.button.copyWith(fontSize: 16.sp),
                        ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 24.h),

        // Back to login
        FadeSlideTransition(
          index: 3,
          child: Center(
            child: TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.login),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                  children: const [
                    TextSpan(text: 'Remember your password? '),
                    TextSpan(
                      text: 'Log in',
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
    );
  }

  // ------------------------------------------------------------------
  // Step 2: OTP entry (future support)
  // ------------------------------------------------------------------
  Widget _buildOtpStep(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),

        FadeSlideTransition(
          index: 1,
          child: Text(
            'We\'ve sent a verification code to your email.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),

        SizedBox(height: 24.h),

        // OTP Input placeholder
        FadeSlideTransition(
          index: 2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.panel,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: colors.border,
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
            child: Column(
              children: [
                Text(
                  'Verification Code',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: controller.otpController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 8,
                    color: colors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: '000000',
                    counterText: '',
                    filled: true,
                    fillColor: colors.inputBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: colors.border,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: colors.border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 24.h),

        // Verify button
        FadeSlideTransition(
          index: 3,
          child: SizedBox(
            width: double.infinity,
            height: 52.h,
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.verifyOtpAndResetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                  shadowColor: AppColors.primary.withOpacity(0.25),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: controller.isLoading.value
                      ? SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.white,
                          ),
                        )
                      : Text(
                          'Verify & Reset',
                          style: AppTextStyles.button.copyWith(fontSize: 16.sp),
                        ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Back to email step
        FadeSlideTransition(
          index: 4,
          child: Center(
            child: TextButton(
              onPressed: () => controller.currentStep.value = 0,
              child: Text(
                'Use a different email',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
