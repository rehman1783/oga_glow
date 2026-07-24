import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/core/network/api_endpoints.dart';
import 'package:oga_glow/features/auth/models/auth_response_model.dart';

/// Handles raw API calls for authentication.
/// No business logic — just HTTP calls and response parsing.
class AuthService {
  final ApiClient _apiClient;

  AuthService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  /// Register a new user.
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    debugPrint('[DEBUG LOG] AuthService: API called (register)');
    final payload = {
      'name': name,
      'email': email,
      'password': password,
    };
    debugPrint('[DEBUG LOG] Request Payload: $payload');

    final response = await _apiClient.post(
      ApiEndpoints.register,
      data: payload,
    );

    debugPrint('[DEBUG LOG] AuthService: Response received. Status Code: ${response.statusCode}');
    debugPrint('[DEBUG LOG] AuthService: Raw Response Data: ${response.data}');

    final parsedModel = RegisterResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );

    debugPrint('[DEBUG LOG] AuthService: Parsed Model success=${parsedModel.success}, message="${parsedModel.message}"');
    return parsedModel;
  }

  /// Login with email and password.
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    return LoginResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  /// Send forgot password request.
  Future<ForgotPasswordResponseModel> forgotPassword({
    required String email,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.forgotPassword,
      data: {
        'email': email,
      },
    );

    return ForgotPasswordResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

