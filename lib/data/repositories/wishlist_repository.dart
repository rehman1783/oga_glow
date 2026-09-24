import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/data/providers/wishlist_api_service.dart';

/// Repository managing Wishlist data and syncing with remote customer wishlist API.
class WishlistRepository {
  final WishlistApiService _apiService;

  WishlistRepository({WishlistApiService? apiService})
      : _apiService = apiService ?? WishlistApiService();

  /// Fetches the user's wishlist items from the API.
  Future<List<Map<String, dynamic>>> getWishlist({bool forceRefresh = false}) async {
    try {
      final res = await _apiService.fetchWishlist(forceRefresh: forceRefresh);
      final rawData = res['data'];
      final List<Map<String, dynamic>> items = [];

      if (rawData is List) {
        for (final entry in rawData) {
          if (entry is Map<String, dynamic>) {
            items.add(_normalizeWishlistItem(entry));
          }
        }
      }
      return items;
    } on ApiException catch (e) {
      debugPrint('[WishlistRepository] ApiException fetching wishlist: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('[WishlistRepository] Error fetching wishlist: $e');
      throw ApiException(message: 'Failed to load wishlist items.');
    }
  }

  /// Toggles a product in the wishlist (adds if absent, removes if present).
  /// Returns a map with `isWishlisted` (bool), `message` (String), and optional `data`.
  Future<Map<String, dynamic>> toggleWishlist(String productId) async {
    try {
      final res = await _apiService.toggleWishlist(productId);
      return {
        'isWishlisted': res['isWishlisted'] == true,
        'message': res['message']?.toString() ?? 'Wishlist updated',
        'data': res['data'],
      };
    } on ApiException catch (e) {
      debugPrint('[WishlistRepository] ApiException toggling wishlist item: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('[WishlistRepository] Error toggling wishlist item: $e');
      throw ApiException(message: 'Failed to update wishlist.');
    }
  }

  /// Removes a single product from wishlist by product ID.
  Future<bool> removeWishlistItem(String productId) async {
    try {
      final res = await _apiService.removeWishlistItem(productId);
      return res['success'] == true;
    } on ApiException catch (e) {
      debugPrint('[WishlistRepository] ApiException removing item: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('[WishlistRepository] Error removing wishlist item: $e');
      throw ApiException(message: 'Failed to remove wishlist item.');
    }
  }

  /// Clears the entire wishlist for the logged-in user.
  Future<bool> clearWishlist() async {
    try {
      final res = await _apiService.clearWishlist();
      return res['success'] == true;
    } on ApiException catch (e) {
      debugPrint('[WishlistRepository] ApiException clearing wishlist: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('[WishlistRepository] Error clearing wishlist: $e');
      throw ApiException(message: 'Failed to clear wishlist.');
    }
  }

  /// Helper to convert raw API wishlist item into a clean normalized Map.
  Map<String, dynamic> _normalizeWishlistItem(Map<String, dynamic> json) {
    final String wishlistId = json['_id']?.toString() ?? json['id']?.toString() ?? '';
    final dynamic rawProduct = json['product'];

    Map<String, dynamic> productMap = {};
    if (rawProduct is Map<String, dynamic>) {
      productMap = Map<String, dynamic>.from(rawProduct);
    } else if (rawProduct is String) {
      productMap = {'_id': rawProduct, 'id': rawProduct};
    } else {
      productMap = Map<String, dynamic>.from(json);
    }

    final String id = productMap['_id']?.toString() ?? productMap['id']?.toString() ?? '';
    final String name = productMap['name']?.toString() ?? productMap['title']?.toString() ?? 'Unnamed Product';
    final String category = productMap['category']?.toString() ?? 'General';
    final dynamic priceRaw = productMap['finalPrice'] ?? productMap['price'] ?? 0;
    final String price = priceRaw.toString();
    final dynamic originalPriceRaw = productMap['price'] ?? priceRaw;
    final String originalPrice = originalPriceRaw.toString();

    String imageUrl = '';
    final dynamic imagesRaw = productMap['images'] ?? productMap['image'];
    if (imagesRaw is List && imagesRaw.isNotEmpty) {
      final firstImg = imagesRaw.first;
      if (firstImg is String) {
        imageUrl = firstImg;
      } else if (firstImg is Map) {
        imageUrl = firstImg['url']?.toString() ?? '';
      }
    } else if (imagesRaw is String) {
      imageUrl = imagesRaw;
    }

    return {
      'id': id,
      '_id': id,
      'wishlistId': wishlistId,
      'name': name,
      'title': name,
      'price': price,
      'originalPrice': originalPrice,
      'image': imageUrl,
      'images': imageUrl.isNotEmpty ? [imageUrl] : [],
      'category': category,
      'description': productMap['description']?.toString() ?? '',
      'productModelRaw': productMap,
    };
  }
}
