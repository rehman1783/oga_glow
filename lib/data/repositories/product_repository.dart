import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/data/providers/product_api_service.dart';

/// Repository providing product data to controllers across the application.
class ProductRepository {
  final ProductApiService _apiService;

  ProductRepository({ProductApiService? apiService})
      : _apiService = apiService ?? ProductApiService();

  /// Fetches all products from API.
  Future<List<ProductModel>> getProducts() async {
    try {
      return await _apiService.fetchProducts();
    } on ApiException catch (e) {
      debugPrint('[ProductRepository] ApiException: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[ProductRepository] Unexpected error: $e\n$stack');
      throw ApiException(
        message: 'Failed to load products. Please check your internet connection.',
      );
    }
  }

  /// Fetches single product details by ID from API.
  Future<ProductModel> getProductById(String id) async {
    try {
      return await _apiService.fetchProductById(id);
    } on ApiException catch (e) {
      debugPrint('[ProductRepository] ApiException for product $id: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[ProductRepository] Unexpected error fetching product $id: $e\n$stack');
      throw ApiException(
        message: 'Failed to load product details. Please try again.',
      );
    }
  }
}
