import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/core/network/api_endpoints.dart';
import 'package:oga_glow/features/home/models/brand_features_model.dart';

class BrandFeaturesService {
  final ApiClient _apiClient;

  BrandFeaturesService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<BrandFeaturesModel> fetchBrandFeatures({bool forceRefresh = false}) async {
    debugPrint('[BrandFeaturesService] Fetching brand features (forceRefresh: $forceRefresh)...');
    final response = await _apiClient.get(
      ApiEndpoints.brandFeatures,
      forceRefresh: forceRefresh,
    );

    debugPrint(
      '[BrandFeaturesService] Response received: ${response.statusCode}',
    );

    if (response.data is Map<String, dynamic>) {
      final payload = BrandFeaturesResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (payload.success && payload.data != null) {
        return payload.data!;
      }

      throw Exception(payload.message ?? 'Brand features data is unavailable.');
    }

    throw Exception('Failed to load brand features: Invalid format');
  }
}
