import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/auth/controllers/auth_controller.dart';
import 'package:oga_glow/features/auth/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;

  LoginController({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;

  // Form validation keys
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
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

  String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) {
      return 'Please enter your password';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // ------------------------------------------------------------------
  // Login
  // ------------------------------------------------------------------

  Future<void> login() async {
    // Manual validation (existing UI uses TextField, not TextFormField)
    final emailError = validateEmail(emailController.text);
    final passwordError = validatePassword(passwordController.text);

    if (emailError != null || passwordError != null) {
      _showError(emailError ?? passwordError!);
      return;
    }

    // Prevent duplicate requests
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      // Call repository
      await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Update auth controller state
      final authController = Get.find<AuthController>();
      await authController.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Navigate to main navigation
      Get.offAllNamed(AppRoutes.mainNavigation);

      Get.snackbar(
        'Login Successful',
        'Welcome back to OGA Glow!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        borderRadius: 14,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } on NotFoundException {
      _showAccountNotFoundError();
    } on UnauthorizedException {
      _showError('Incorrect email or password. Please try again.');
    } on BadRequestException catch (e) {
      if (e.message.toLowerCase().contains('not found') ||
          e.message.toLowerCase().contains('exist')) {
        _showAccountNotFoundError();
      } else {
        _showError('Incorrect email or password. Please try again.');
      }
    } on NetworkException {
      _showError('No internet connection. Please check your network.');
    } on TimeoutException {
      _showError('Request timed out. Please try again.');
    } on ServerException {
      _showError('Server error. Please try again later.');
    } on ApiException catch (e) {
      if (e.message.toLowerCase().contains('not found') ||
          e.message.toLowerCase().contains('exist')) {
        _showAccountNotFoundError();
      } else {
        _showError(e.message);
      }
    } catch (e) {
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void _showAccountNotFoundError() {
    Get.snackbar(
      'Account Not Found',
      'No account found with this email.\nPlease create a new account.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () => Get.toNamed(AppRoutes.signup),
        child: const Text(
          'Go to Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  void _showError(String message) {
    Get.snackbar(
      'Login Failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 4),
    );
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void navigateToSignup() {
    Get.toNamed(AppRoutes.signup);
  }

  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }
}
