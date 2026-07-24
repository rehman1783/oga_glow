class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}

class NetworkException extends ApiException {
  NetworkException({String? message})
      : super(
          message: message ?? 'No internet connection. Please check your network.',
          statusCode: null,
        );
}

class TimeoutException extends ApiException {
  TimeoutException({String? message})
      : super(
          message: message ?? 'Request timed out. Please try again.',
          statusCode: null,
        );
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({String? message})
      : super(
          message: message ?? 'Session expired. Please login again.',
          statusCode: 401,
        );
}

class ServerException extends ApiException {
  ServerException({String? message, int? statusCode})
      : super(
          message: message ?? 'Something went wrong on the server.',
          statusCode: statusCode ?? 500,
        );
}

class BadRequestException extends ApiException {
  BadRequestException({String? message, dynamic data})
      : super(
          message: message ?? 'Invalid request.',
          statusCode: 400,
          data: data,
        );
}

class NotFoundException extends ApiException {
  NotFoundException({String? message})
      : super(
          message: message ?? 'Resource not found.',
          statusCode: 404,
        );
}

