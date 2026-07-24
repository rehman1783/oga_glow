import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/core/storage/secure_storage.dart';
import 'package:oga_glow/features/auth/models/auth_response_model.dart';
import 'package:oga_glow/features/auth/models/user_model.dart';
import 'package:oga_glow/features/auth/services/auth_service.dart';

/// Repository that bridges AuthService (network) and SecureStorage (local).
/// Business-logic layer: decides what to store, when to throw, etc.
class AuthRepository {
  final AuthService _authService;
  final SecureStorage _secureStorage;

  AuthRepository({AuthService? authService, SecureStorage? secureStorage})
    : _authService = authService ?? AuthService(),
      _secureStorage = secureStorage ?? SecureStorage();

  // ------------------------------------------------------------------
  // Register
  // ------------------------------------------------------------------

  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    debugPrint('[DEBUG LOG] AuthRepository: called (register)');
    try {
      final response = await _authService.register(
        name: name.trim(),
        email: email.trim().toLowerCase(),
        password: password,
      );
      debugPrint('[DEBUG LOG] AuthRepository: received response from AuthService (success=${response.success})');
      return response;
    } on ApiException catch (e) {
      debugPrint('[DEBUG LOG] AuthRepository: ApiException caught -> ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[DEBUG LOG] AuthRepository: unexpected error -> $e\n$stack');
      throw ApiException(message: 'Registration failed. Please try again.');
    }
  }

  // ------------------------------------------------------------------
  // Login
  // ------------------------------------------------------------------

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authService.login(
        email: email.trim().toLowerCase(),
        password: password,
      );

      // Persist token and user data on successful login
      await _secureStorage.saveToken(result.token);
      await _secureStorage.saveUser(jsonEncode(result.user.toJson()));

      return result;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Login failed. Please try again.');
    }
  }

  // ------------------------------------------------------------------
  // Forgot Password
  // ------------------------------------------------------------------

  Future<ForgotPasswordResponseModel> forgotPassword({
    required String email,
  }) async {
    try {
      return await _authService.forgotPassword(
        email: email.trim().toLowerCase(),
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: 'Failed to process request. Please try again.',
      );
    }
  }

  // ------------------------------------------------------------------
  // Session
  // ------------------------------------------------------------------

  /// Check if a valid token exists in local storage.
  Future<bool> isLoggedIn() async {
    return _secureStorage.hasToken();
  }

  /// Retrieve the stored token.
  Future<String?> getToken() async {
    return _secureStorage.getToken();
  }

  /// Retrieve the stored user.
  Future<UserModel?> getUser() async {
    final userJson = await _secureStorage.getUser();
    if (userJson == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  /// Logout: clear all stored auth data.
  Future<void> logout() async {
    await _secureStorage.clearAll();
  }
}
