import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/core/network/api_endpoints.dart';
import 'package:oga_glow/data/models/product_model.dart';

/// Handles raw API calls for Products.
class ProductApiService {
  final ApiClient _apiClient;

  ProductApiService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  /// Fetches all products from GET /ogaglow/products
  Future<List<ProductModel>> fetchProducts() async {
    debugPrint('[ProductApiService] Fetching products from ${ApiEndpoints.products}...');
    final response = await _apiClient.get(ApiEndpoints.products);

    debugPrint('[ProductApiService] Response status: ${response.statusCode}');

    final data = response.data;
    if (data is Map<String, dynamic> && data['data'] != null) {
      final listData = data['data'];
      if (listData is List) {
        return listData
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } else if (data is List) {
      return data
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  /// Fetches single product details by ID from GET /ogaglow/products/:id
  Future<ProductModel> fetchProductById(String id) async {
    debugPrint('[ProductApiService] Fetching product by ID: $id');
    final response = await _apiClient.get(ApiEndpoints.productDetails(id));

    debugPrint('[ProductApiService] Response status: ${response.statusCode}');

    final data = response.data;
    if (data is Map<String, dynamic>) {
      final productData = data['data'] ?? data;
      if (productData is Map<String, dynamic>) {
        return ProductModel.fromJson(productData);
      }
    }

    throw Exception('Failed to load product details for ID: $id');
  }
}
