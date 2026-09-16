
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

  final Map<String, _HttpCacheEntry> _cache = {};
  final Map<String, Future<dynamic>> _inFlightRequests = {};

  String _buildCacheKey(String path, Map<String, dynamic>? queryParameters) {
    if (queryParameters == null || queryParameters.isEmpty) {
      return path;
    }
    final sortedKeys = queryParameters.keys.toList()..sort();
    final queryStr = sortedKeys.map((k) => '$k=${queryParameters[k]}').join('&');
    return '$path?$queryStr';
  }

  /// Clears the HTTP cache completely or for a specific endpoint prefix.
  void clearCache([String? pathPrefix]) {
    if (pathPrefix == null) {
      _cache.clear();
      debugPrint('[ApiClient] Entire HTTP cache cleared');
    } else {
      _cache.removeWhere((key, _) => key.startsWith(pathPrefix));
      debugPrint('[ApiClient] HTTP cache cleared for prefix: $pathPrefix');
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    Duration ttl = const Duration(minutes: 5),
    bool forceRefresh = false,
  }) async {
    final cacheKey = _buildCacheKey(path, queryParameters);

    // 1. Check in-memory cache if not forcing refresh
    if (!forceRefresh) {
      final cached = _cache[cacheKey];
      if (cached != null && !cached.isExpired) {
        debugPrint('[ApiClient] Cache HIT for $cacheKey (age: ${DateTime.now().difference(cached.timestamp).inSeconds}s)');
        return Response<T>(
          data: cached.response.data as T,
          headers: cached.response.headers,
          requestOptions: cached.response.requestOptions,
          isRedirect: cached.response.isRedirect,
          statusCode: cached.response.statusCode,
          statusMessage: cached.response.statusMessage,
          redirects: cached.response.redirects,
          extra: cached.response.extra,
        );
      }
    }

    // 2. In-flight request deduplication: if request is already ongoing, join it
    if (!forceRefresh && _inFlightRequests.containsKey(cacheKey)) {
      debugPrint('[ApiClient] In-flight DEDUPLICATION joined for $cacheKey');
      final inFlightResponse = await _inFlightRequests[cacheKey]!;
      return Response<T>(
        data: inFlightResponse.data as T,
        headers: inFlightResponse.headers,
        requestOptions: inFlightResponse.requestOptions,
        isRedirect: inFlightResponse.isRedirect,
        statusCode: inFlightResponse.statusCode,
        statusMessage: inFlightResponse.statusMessage,
        redirects: inFlightResponse.redirects,
        extra: inFlightResponse.extra,
      );
    }

    // 3. Dispatch new network call & save to inFlightRequests
    final requestFuture = _sendRequest<T>(() => _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    ));

    _inFlightRequests[cacheKey] = requestFuture;

    try {
      final response = await requestFuture;
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        _cache[cacheKey] = _HttpCacheEntry(
          response: response,
          timestamp: DateTime.now(),
          ttl: ttl,
        );
      }
      return response;
    } finally {
      _inFlightRequests.remove(cacheKey);
    }
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

class _HttpCacheEntry {
  final Response response;
  final DateTime timestamp;
  final Duration ttl;

  _HttpCacheEntry({
    required this.response,
    required this.timestamp,
    required this.ttl,
  });

  bool get isExpired => DateTime.now().difference(timestamp) > ttl;
}