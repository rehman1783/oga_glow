/// Generic API response wrapper matching the backend response format.
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? token;
  final dynamic error;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.token,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic)? fromJsonT,
  }) {
    return ApiResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      token: json['token'] as String?,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (data != null) 'data': data,
      if (token != null) 'token': token,
      if (error != null) 'error': error,
    };
  }
}

/// For list responses where data is a list.
class ApiListResponse<T> {
  final bool success;
  final String message;
  final List<T>? data;

  ApiListResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiListResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic)? fromJsonT,
  }) {
    return ApiListResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => fromJsonT!(e))
          .toList(),
    );
  }
}

