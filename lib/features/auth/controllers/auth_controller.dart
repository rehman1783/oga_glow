import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/features/auth/models/user_model.dart';
import 'package:oga_glow/features/auth/repositories/auth_repository.dart';

/// Global authentication controller.
/// Manages auth state across the entire app.
class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository();

  // ---------------------------------------------------------------
  // Reactive state
  // ---------------------------------------------------------------

  /// Currently logged-in user (null if not logged in).
  final currentUser = Rx<UserModel?>(null);

  /// Current JWT token (null if not logged in).
  final currentToken = Rx<String?>(null);

  /// Whether the user is logged in.
  final isLoggedIn = false.obs;

  /// Whether auth state is being loaded (e.g., during auto-login check).
  final isLoading = true.obs;

  // ---------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();
    _loadSession();
  }

  /// Check stored token and user on app start.
  Future<void> _loadSession() async {
    isLoading.value = true;
    try {
      final hasToken = await _authRepository.isLoggedIn();
      if (hasToken) {
        final token = await _authRepository.getToken();
        final user = await _authRepository.getUser();

        if (token != null && user != null) {
          currentToken.value = token;
          currentUser.value = user;
          isLoggedIn.value = true;
        }
      }
    } catch (_) {
      // If anything fails during session load, treat as logged out.
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------
  // Login
  // ---------------------------------------------------------------

  Future<void> login({required String email, required String password}) async {
    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    // Update reactive state
    currentToken.value = result.token;
    currentUser.value = result.user;
    isLoggedIn.value = true;
  }

  // ---------------------------------------------------------------
  // Logout
  // ---------------------------------------------------------------

  Future<void> logout() async {
    await _authRepository.logout();

    currentToken.value = null;
    currentUser.value = null;
    isLoggedIn.value = false;

    // Show logout success message
    Get.snackbar(
      'Logout Successful',
      'You have been logged out successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );

    // Navigate to login screen and clear navigation stack
    Get.offAllNamed(AppRoutes.login);
  }

  // ---------------------------------------------------------------
  // Delete Account
  // ---------------------------------------------------------------

  Future<void> deleteAccount() async {
    await _authRepository.deleteAccount();

    currentToken.value = null;
    currentUser.value = null;
    isLoggedIn.value = false;

    Get.snackbar(
      'Account Deleted',
      'Your account has been deleted successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      borderRadius: 14,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );

    Get.offAllNamed(AppRoutes.login);
  }

  // ---------------------------------------------------------------
  // Auto-login decision helper
  // ---------------------------------------------------------------

  /// Returns the initial route based on stored session.
  Future<String> getInitialRoute() async {
    await _loadSession();
    if (isLoggedIn.value) {
      return AppRoutes.mainNavigation;
    }
    return AppRoutes.entry;
  }
}
