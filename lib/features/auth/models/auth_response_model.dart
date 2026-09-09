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
    final payload = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final token = json['token']?.toString() ??
        payload['token']?.toString() ??
        json['accessToken']?.toString() ??
        payload['accessToken']?.toString() ??
        '';

    final userRaw = payload['user'] ??
        json['user'] ??
        (payload.containsKey('email') || payload.containsKey('name') ? payload : null);

    return LoginResponseModel(
      success: json['success'] as bool? ?? token.isNotEmpty,
      message: json['message']?.toString() ?? payload['message']?.toString() ?? '',
      token: token,
      user: userRaw is Map<String, dynamic>
          ? UserModel.fromJson(userRaw)
          : UserModel.fromJson({}),
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
  final String? token;

  RegisterResponseModel({
    required this.success,
    required this.message,
    this.user,
    this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final payload = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final userRaw = payload['user'] ??
        json['user'] ??
        (payload.containsKey('email') || payload.containsKey('name') ? payload : null);

    UserModel? parsedUser;
    if (userRaw is Map<String, dynamic>) {
      parsedUser = UserModel.fromJson(userRaw);
    }

    final token = json['token']?.toString() ?? payload['token']?.toString();

    return RegisterResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message']?.toString() ?? payload['message']?.toString() ?? '',
      user: parsedUser,
      token: token != null && token.isNotEmpty ? token : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (user != null) 'user': user!.toJson(),
      if (token != null) 'token': token,
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

