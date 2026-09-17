import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants/order_models.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_exception.dart';

class OrderService {
  final ApiClient _apiClient;

  OrderService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  /// Fetches the real order history for the currently authenticated user.
  /// Calls GET /OGAGLOW/orders/my-orders
  Future<List<OrderModel>> getMyOrders({bool forceRefresh = false}) async {
    debugPrint(
      '[OrderService] Fetching real orders from ${ApiEndpoints.myOrders} (forceRefresh: $forceRefresh)...',
    );

    try {
      final Response response = await _apiClient.get(
        ApiEndpoints.myOrders,
        forceRefresh: forceRefresh,
        ttl: const Duration(minutes: 2),
      );
      final data = response.data;

      debugPrint(
        '[OrderService] Orders response received. Status: ${response.statusCode}',
      );

      List<dynamic> rawOrdersList = [];

      if (data is Map<String, dynamic>) {
        final payload =
            data['data'] ??
            data['orders'] ??
            data['myOrders'] ??
            data['result'];
        if (payload is List) {
          rawOrdersList = payload;
        } else if (payload is Map<String, dynamic>) {
          rawOrdersList = [payload];
        }
      } else if (data is List) {
        rawOrdersList = data;
      }

      final orders = rawOrdersList
          .whereType<Map<String, dynamic>>()
          .map(OrderModel.fromJson)
          .toList();

      debugPrint(
        '[OrderService] Successfully parsed ${orders.length} real orders from backend.',
      );
      return orders;
    } on UnauthorizedException catch (e) {
      debugPrint(
        '[OrderService] UnauthorizedException: User is not logged in -> ${e.message}',
      );
      rethrow;
    } on ApiException catch (e) {
      debugPrint('[OrderService] ApiException fetching orders: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('[OrderService] Unexpected error fetching orders: $e');
      throw ApiException(message: 'Failed to fetch orders: $e');
    }
  }
}
