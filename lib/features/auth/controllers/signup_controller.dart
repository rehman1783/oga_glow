import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/auth/repositories/auth_repository.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository;

  SignupController({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // ------------------------------------------------------------------
  // Validation
  // ------------------------------------------------------------------

  String? validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return 'Please enter your full name';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

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
      return 'Please enter a password';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // ------------------------------------------------------------------
  // Signup
  // ------------------------------------------------------------------

  Future<void> signup() async {
    debugPrint('[DEBUG LOG] SignupController: Register button pressed');
    
    // Manual validation
    final nameError = validateName(nameController.text);
    final emailError = validateEmail(emailController.text);
    final passwordError = validatePassword(passwordController.text);

    if (nameError != null || emailError != null || passwordError != null) {
      final firstError = nameError ?? emailError ?? passwordError!;
      debugPrint('[DEBUG LOG] SignupController: Validation failed -> $firstError');
      _showError(firstError);
      return;
    }

    debugPrint('[DEBUG LOG] SignupController: Validation passed');

    if (isLoading.value) return;

    isLoading.value = true;
    try {
      debugPrint('[DEBUG LOG] SignupController: Controller executing, calling repository');
      final response = await _authRepository.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      debugPrint('[DEBUG LOG] SignupController: API call returned response. Success: ${response.success}, Message: "${response.message}"');

      if (response.success) {
        debugPrint('[DEBUG LOG] SignupController: Registration successful from backend response.');
        
        Get.snackbar(
          'Account Created Successfully',
          'Verification Email Sent. Please check your inbox to verify your account.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          borderRadius: 14,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        );

        final email = emailController.text.trim();
        debugPrint('[DEBUG LOG] SignupController: Triggering navigation to Verification Screen for email $email');
        Get.offAllNamed(AppRoutes.verification, arguments: email);
      } else {
        debugPrint('[DEBUG LOG] SignupController: API returned success=false');
        if (response.message.toLowerCase().contains('already exists') ||
            response.message.toLowerCase().contains('already registered')) {
          _showAlreadyRegisteredError();
        } else {
          _showError(response.message.isNotEmpty ? response.message : 'Registration failed.');
        }
      }
    } on BadRequestException catch (e) {
      debugPrint('[DEBUG LOG] SignupController: BadRequestException caught -> ${e.message}');
      if (e.message.toLowerCase().contains('already exists') ||
          e.message.toLowerCase().contains('already registered')) {
        _showAlreadyRegisteredError();
      } else {
        _showError(e.message);
      }
    } on NetworkException catch (e) {
      debugPrint('[DEBUG LOG] SignupController: NetworkException caught -> ${e.message}');
      _showError('No internet connection. Please check your network.');
    } on TimeoutException catch (e) {
      debugPrint('[DEBUG LOG] SignupController: TimeoutException caught -> ${e.message}');
      _showError('Request timed out. Please try again.');
    } on ServerException catch (e) {
      debugPrint('[DEBUG LOG] SignupController: ServerException caught -> ${e.message}');
      _showError('Server error. Please try again later.');
    } on ApiException catch (e) {
      debugPrint('[DEBUG LOG] SignupController: ApiException caught -> ${e.message}');
      if (e.message.toLowerCase().contains('already exists') ||
          e.message.toLowerCase().contains('already registered')) {
        _showAlreadyRegisteredError();
      } else {
        _showError(e.message);
      }
    } catch (e, stack) {
      debugPrint('[DEBUG LOG] SignupController: Unexpected error caught -> $e\n$stack');
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void _showAlreadyRegisteredError() {
    Get.snackbar(
      'Account Exists',
      'This email is already registered.\nPlease login instead.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () => Get.offAllNamed(AppRoutes.login),
        child: const Text(
          'Go to Login',
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
      'Registration Failed',
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

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void navigateToLogin() {
    Get.toNamed(AppRoutes.login);
  }
}
