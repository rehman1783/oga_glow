import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/core/network/api_endpoints.dart';

/// Handles raw API calls for Customer Wishlist.
class WishlistApiService {
  final ApiClient _apiClient;

  WishlistApiService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  /// GET /customers/me/wishlist
  Future<Map<String, dynamic>> fetchWishlist({bool forceRefresh = false}) async {
    debugPrint('[WishlistApiService] Fetching customer wishlist...');
    final response = await _apiClient.get(
      ApiEndpoints.customerWishlist,
      forceRefresh: forceRefresh,
    );
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {'success': false, 'data': []};
  }

  /// POST /customers/me/wishlist/toggle
  Future<Map<String, dynamic>> toggleWishlist(String productId) async {
    debugPrint('[WishlistApiService] Toggling wishlist for product: $productId');
    final response = await _apiClient.post(
      ApiEndpoints.toggleWishlist,
      data: {'productId': productId},
    );
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {'success': false};
  }

  /// DELETE /customers/me/wishlist/item/:productId
  Future<Map<String, dynamic>> removeWishlistItem(String productId) async {
    debugPrint('[WishlistApiService] Removing item $productId from wishlist');
    final response = await _apiClient.delete(
      ApiEndpoints.removeWishlistItem(productId),
    );
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {'success': false};
  }

  /// DELETE /customers/me/wishlist/clear
  Future<Map<String, dynamic>> clearWishlist() async {
    debugPrint('[WishlistApiService] Clearing entire wishlist');
    final response = await _apiClient.delete(
      ApiEndpoints.clearWishlist,
    );
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return {'success': false};
  }
}
