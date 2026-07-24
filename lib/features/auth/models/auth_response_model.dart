import 'user_model.dart';

/// Wrapper for login API response.
class LoginResponseModel {
  final bool success;
  final String message;
  final String token;
  final UserModel user;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      token: json['token'] as String? ?? '',
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
      'user': user.toJson(),
    };
  }
}

/// Wrapper for register API response.
class RegisterResponseModel {
  final bool success;
  final String message;
  final UserModel? user;

  RegisterResponseModel({
    required this.success,
    required this.message,
    this.user,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    UserModel? parsedUser;
    final userData = json['data'] ?? json['user'];
    if (userData is Map<String, dynamic>) {
      parsedUser = UserModel.fromJson(userData);
    }

    return RegisterResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      user: parsedUser,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (user != null) 'user': user!.toJson(),
    };
  }
}

/// Wrapper for forgot-password API response.
class ForgotPasswordResponseModel {
  final bool success;
  final String message;

  ForgotPasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}

