import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/data/providers/product_api_service.dart';

/// Repository providing product data to controllers across the application.
class ProductRepository {
  static List<ProductModel>? _cachedProducts;
  static DateTime? _productsCacheTime;
  static final Map<String, ProductModel> _productByIdCache = {};
  static final Map<String, DateTime> _productByIdCacheTime = {};
  static const Duration _cacheTtl = Duration(minutes: 5);

  final ProductApiService _apiService;

  ProductRepository({ProductApiService? apiService})
      : _apiService = apiService ?? ProductApiService();

  /// Synchronously lookup a product by ID from cached memory if available
  static ProductModel? findCachedProduct(String id) {
    if (_productByIdCache.containsKey(id)) {
      return _productByIdCache[id];
    }
    if (_cachedProducts != null) {
      try {
        return _cachedProducts!.firstWhere((p) => p.id == id);
      } catch (_) {}
    }
    return null;
  }

  /// Clears in-memory product caches
  static void clearProductCache() {
    _cachedProducts = null;
    _productsCacheTime = null;
    _productByIdCache.clear();
    _productByIdCacheTime.clear();
  }

  /// Fetches all products from API or returns cached memory list if fresh.
  Future<List<ProductModel>> getProducts({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cachedProducts != null &&
        _productsCacheTime != null &&
        DateTime.now().difference(_productsCacheTime!) < _cacheTtl) {
      debugPrint('[ProductRepository] Returning ${_cachedProducts!.length} products from memory cache');
      return _cachedProducts!;
    }

    try {
      final products = await _apiService.fetchProducts(forceRefresh: forceRefresh);
      _cachedProducts = products;
      _productsCacheTime = DateTime.now();
      for (final p in products) {
        _productByIdCache[p.id] = p;
        _productByIdCacheTime[p.id] = DateTime.now();
      }
      return products;
    } on ApiException catch (e) {
      debugPrint('[ProductRepository] ApiException: ${e.message}');
      if (_cachedProducts != null && _cachedProducts!.isNotEmpty) {
        return _cachedProducts!;
      }
      rethrow;
    } catch (e, stack) {
      debugPrint('[ProductRepository] Unexpected error: $e\n$stack');
      if (_cachedProducts != null && _cachedProducts!.isNotEmpty) {
        return _cachedProducts!;
      }
      throw ApiException(
        message: 'Failed to load products. Please check your internet connection.',
      );
    }
  }

  /// Fetches single product details by ID from API or returns cached model.
  Future<ProductModel> getProductById(String id, {bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _productByIdCache.containsKey(id) &&
        _productByIdCacheTime[id] != null &&
        DateTime.now().difference(_productByIdCacheTime[id]!) < _cacheTtl) {
      debugPrint('[ProductRepository] Returning product $id from memory cache');
      return _productByIdCache[id]!;
    }

    try {
      final product = await _apiService.fetchProductById(id, forceRefresh: forceRefresh);
      _productByIdCache[id] = product;
      _productByIdCacheTime[id] = DateTime.now();
      return product;
    } on ApiException catch (e) {
      debugPrint('[ProductRepository] ApiException for product $id: ${e.message}');
      if (_productByIdCache.containsKey(id)) {
        return _productByIdCache[id]!;
      }
      rethrow;
    } catch (e, stack) {
      debugPrint('[ProductRepository] Unexpected error fetching product $id: $e\n$stack');
      if (_productByIdCache.containsKey(id)) {
        return _productByIdCache[id]!;
      }
      throw ApiException(
        message: 'Failed to load product details. Please try again.',
      );
    }
  }
}
