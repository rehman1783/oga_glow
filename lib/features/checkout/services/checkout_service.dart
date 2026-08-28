import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../models/checkout_preview_model.dart';
import '../models/place_order_model.dart';

class CheckoutService {
  final ApiClient _apiClient;

  CheckoutService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  /// 1. Checkout Preview API
  /// Computes price breakdown, discounts, shipping, and coupon validation.
  Future<CheckoutPreviewResponse> getCheckoutPreview({
    required List<Map<String, dynamic>> items,
    String? couponCode,
  }) async {
    final body = <String, dynamic>{
      'orderItems': items,
      'items': items,
      if (couponCode != null && couponCode.trim().isNotEmpty)
        'couponCode': couponCode.trim(),
    };

    final Response response = await _apiClient.post(
      ApiEndpoints.checkoutPreview,
      data: body,
    );

    if (response.data is Map<String, dynamic>) {
      return CheckoutPreviewResponse.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Invalid response format from checkout preview endpoint.');
    }
  }

  /// 2. Place Order API
  /// Creates order, reserves stock, books Leopards Courier tracking, returns order details.
  Future<PlaceOrderResponse> placeOrder(PlaceOrderRequest orderPayload) async {
    final Response response = await _apiClient.post(
      ApiEndpoints.placeOrder,
      data: orderPayload.toJson(),
    );

    if (response.data is Map<String, dynamic>) {
      return PlaceOrderResponse.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Invalid response format from place order endpoint.');
    }
  }
}
