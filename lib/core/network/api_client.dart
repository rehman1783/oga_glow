import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_endpoints.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/core/storage/secure_storage.dart';

class ApiClient {
  static ApiClient? _instance;
  late final Dio _dio;
  late final SecureStorage _secureStorage;

  ApiClient._internal() {
    _secureStorage = SecureStorage();
    _dio = _createDio();
  }

  factory ApiClient() {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  Dio get dio => _dio;
  SecureStorage get secureStorage => _secureStorage;

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Attach auth token if available
          final token = await _secureStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          debugPrint('================ HTTP REQUEST ================');
          debugPrint('URL: ${options.baseUrl}${options.path}');
          debugPrint('Method: ${options.method}');
          debugPrint('Headers: ${options.headers}');
          debugPrint('Body: ${options.data}');
          debugPrint('==============================================');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('================ HTTP RESPONSE ================');
          debugPrint('URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
          debugPrint('Status Code: ${response.statusCode}');
          debugPrint('Headers: ${response.headers.map}');
          debugPrint('Response Body: ${response.data}');
          debugPrint('===============================================');
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint('================ HTTP ERROR ================');
          debugPrint('URL: ${error.requestOptions.baseUrl}${error.requestOptions.path}');
          debugPrint('Status Code: ${error.response?.statusCode}');
          debugPrint('Error Response Body: ${error.response?.data}');
          debugPrint('Error Type: ${error.type}');
          debugPrint('Error Message: ${error.message}');
          debugPrint('============================================');
          final exception = _handleDioError(error);
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: exception,
              response: error.response,
              type: error.type,
            ),
          );
        },
      ),
    );

    return dio;
  }

  /// Central error handler that converts DioExceptions into custom exceptions.
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();

      case DioExceptionType.connectionError:
        return NetworkException();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;

        String message = 'Something went wrong.';
        dynamic responseData = data;
        if (responseData is String && responseData.trim().startsWith('{')) {
          try {
            responseData = jsonDecode(responseData);
          } catch (_) {}
        }
        if (responseData is Map<String, dynamic>) {
          message = responseData['message'] as String? ??
              responseData['error'] as String? ??
              responseData['msg'] as String? ??
              message;
        }

        switch (statusCode) {
          case 400:
            return BadRequestException(message: message, data: responseData);
          case 401:
            return UnauthorizedException(message: message);
          case 404:
            return NotFoundException(message: message);
          case 500:
          case 502:
          case 503:
            return ServerException(message: message, statusCode: statusCode);
          default:
            return ApiException(
              message: message,
              statusCode: statusCode,
              data: responseData,
            );
        }

      case DioExceptionType.cancel:
        return ApiException(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return ApiException(message: 'Bad SSL certificate.');

      case DioExceptionType.unknown:
      default:
        if (error.error is ApiException) {
          return error.error as ApiException;
        }
        return NetworkException(
          message: 'Unable to connect to server. Please try again.',
        );
    }
  }

  // ---------------------------------------------------------------------------
  // HTTP helpers
  // ---------------------------------------------------------------------------

  Future<Response<T>> _sendRequest<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error as ApiException;
      }
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _sendRequest(() => _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    ));
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _sendRequest(() => _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    ));
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _sendRequest(() => _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    ));
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _sendRequest(() => _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    ));
  }
}

