import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/core/network/api_endpoints.dart';
import 'package:oga_glow/core/network/api_exception.dart';

/// Handles raw API calls for Customer Wishlist with graceful 404 handling.
class WishlistApiService {
  final ApiClient _apiClient;

  WishlistApiService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  static final Options _allow404Options = Options(
    validateStatus: (status) => status != null && status < 500,
  );

  /// GET /customers/me/wishlist
  Future<Map<String, dynamic>> fetchWishlist({bool forceRefresh = false}) async {
    debugPrint('[WishlistApiService] Fetching customer wishlist...');
    try {
      final response = await _apiClient.get(
        ApiEndpoints.customerWishlist,
        options: _allow404Options,
        forceRefresh: forceRefresh,
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      if (response.statusCode == 404) {
        debugPrint('[WishlistApiService] Wishlist endpoint 404 - using local fallback');
      }
    } on ApiException catch (e) {
      debugPrint('[WishlistApiService] Wishlist fetch exception (${e.statusCode}): ${e.message}');
    } catch (e) {
      debugPrint('[WishlistApiService] Unexpected error fetching wishlist: $e');
    }
    return {'success': false, 'data': []};
  }

  /// POST /customers/me/wishlist/toggle
  Future<Map<String, dynamic>> toggleWishlist(String productId) async {
    debugPrint('[WishlistApiService] Toggling wishlist for product: $productId');
    try {
      final response = await _apiClient.post(
        ApiEndpoints.toggleWishlist,
        data: {'productId': productId},
        options: _allow404Options,
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      if (response.statusCode == 404) {
        debugPrint('[WishlistApiService] Wishlist toggle endpoint 404 - using local toggle');
      }
    } on ApiException catch (e) {
      debugPrint('[WishlistApiService] Wishlist toggle exception (${e.statusCode}): ${e.message}');
    } catch (e) {
      debugPrint('[WishlistApiService] Unexpected error toggling wishlist: $e');
    }
    return {'success': false};
  }

  /// DELETE /customers/me/wishlist/item/:productId
  Future<Map<String, dynamic>> removeWishlistItem(String productId) async {
    debugPrint('[WishlistApiService] Removing item $productId from wishlist');
    try {
      final response = await _apiClient.delete(
        ApiEndpoints.removeWishlistItem(productId),
        options: _allow404Options,
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      if (response.statusCode == 404) {
        debugPrint('[WishlistApiService] Wishlist remove endpoint 404');
      }
    } on ApiException catch (e) {
      debugPrint('[WishlistApiService] Wishlist remove exception (${e.statusCode}): ${e.message}');
    } catch (e) {
      debugPrint('[WishlistApiService] Unexpected error removing wishlist item: $e');
    }
    return {'success': false};
  }

  /// DELETE /customers/me/wishlist/clear
  Future<Map<String, dynamic>> clearWishlist() async {
    debugPrint('[WishlistApiService] Clearing entire wishlist');
    try {
      final response = await _apiClient.delete(
        ApiEndpoints.clearWishlist,
        options: _allow404Options,
      );
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      if (response.statusCode == 404) {
        debugPrint('[WishlistApiService] Wishlist clear endpoint 404');
      }
    } on ApiException catch (e) {
      debugPrint('[WishlistApiService] Wishlist clear exception (${e.statusCode}): ${e.message}');
    } catch (e) {
      debugPrint('[WishlistApiService] Unexpected error clearing wishlist: $e');
    }
    return {'success': false};
  }
}
