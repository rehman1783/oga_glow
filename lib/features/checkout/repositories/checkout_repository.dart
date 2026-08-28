import 'package:flutter/foundation.dart';
import '../../../core/network/api_exception.dart';
import '../models/checkout_preview_model.dart';
import '../models/place_order_model.dart';
import '../services/checkout_service.dart';

class CheckoutRepository {
  final CheckoutService _service;

  CheckoutRepository({CheckoutService? service})
      : _service = service ?? CheckoutService();

  /// Fetches price calculation preview from backend
  Future<CheckoutPreviewResponse> getCheckoutPreview({
    required List<Map<String, dynamic>> items,
    String? couponCode,
  }) async {
    try {
      return await _service.getCheckoutPreview(
        items: items,
        couponCode: couponCode,
      );
    } on ApiException catch (e) {
      debugPrint('[CheckoutRepository] ApiException in preview: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[CheckoutRepository] Unexpected error in preview: $e\n$stack');
      throw ApiException(
        message: 'Unable to calculate checkout totals. Please check your network.',
      );
    }
  }

  /// Places a customer order
  Future<PlaceOrderResponse> placeOrder(PlaceOrderRequest payload) async {
    try {
      return await _service.placeOrder(payload);
    } on ApiException catch (e) {
      debugPrint('[CheckoutRepository] ApiException in placeOrder: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[CheckoutRepository] Unexpected error in placeOrder: $e\n$stack');
      throw ApiException(
        message: 'Order placement failed. Please try again.',
      );
    }
  }
}
