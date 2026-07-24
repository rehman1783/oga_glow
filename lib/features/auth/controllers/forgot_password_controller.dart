import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/auth/repositories/auth_repository.dart';

/// Controller for the Forgot Password screen.
/// Designed to support both email-link and OTP verification flows.
class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepository;

  ForgotPasswordController({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  final emailController = TextEditingController();
  final isLoading = false.obs;

  // For future OTP/reset password flow
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Current step in the flow: 0 = email entry, 1 = OTP/reset step
  final currentStep = 0.obs;

  /// Whether the backend sent an OTP (vs email link)
  final isOtpFlow = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // ------------------------------------------------------------------
  // Validation
  // ------------------------------------------------------------------

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // ------------------------------------------------------------------
  // Send forgot password request
  // ------------------------------------------------------------------

  Future<void> sendForgotPasswordRequest() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final result = await _authRepository.forgotPassword(
        email: emailController.text.trim(),
      );

      // Success — determine if it's an OTP or email-link flow
      // Based on response we can infer flow type.
      // For now we assume email-link by default, but the architecture
      // supports OTP verification by setting isOtpFlow = true.
      isOtpFlow.value = _detectFlowType(result.message);

      // Show success
      Get.snackbar(
        'Email Sent!',
        result.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        borderRadius: 14,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      );

      // If it's an OTP flow, move to next step
      if (isOtpFlow.value) {
        currentStep.value = 1;
      } else {
        // Email link flow — navigate back to login
        Get.offAllNamed(AppRoutes.login);
      }
    } on NotFoundException {
      _showError('No account found with this email address.');
    } on NetworkException {
      _showError('No internet connection. Please check your network.');
    } on TimeoutException {
      _showError('Request timed out. Please try again.');
    } on ServerException {
      _showError('Server error. Please try again later.');
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  /// Detect if the response message indicates an OTP was sent.
  bool _detectFlowType(String message) {
    final lower = message.toLowerCase();
    return lower.contains('otp') || lower.contains('code') || lower.contains('verification');
  }

  // ------------------------------------------------------------------
  // Future: Verify OTP / Reset Password
  // ------------------------------------------------------------------

  /// This method can be extended when the backend supports OTP-based
  /// password reset. For now it's a placeholder for future use.
  Future<void> verifyOtpAndResetPassword() async {
    // TODO: Implement when OTP/reset endpoint is available.
    Get.snackbar(
      'Coming Soon',
      'OTP verification will be available soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
    );
  }

  void _showError(String message) {
    Get.snackbar(
      'Failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  void navigateToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }
}

