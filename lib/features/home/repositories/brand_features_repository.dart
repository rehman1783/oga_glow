import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/home/models/brand_features_model.dart';
import 'package:oga_glow/features/home/services/brand_features_service.dart';

class BrandFeaturesRepository {
  final BrandFeaturesService _service;

  BrandFeaturesRepository({BrandFeaturesService? service})
    : _service = service ?? BrandFeaturesService();

  Future<BrandFeaturesModel> getBrandFeatures() async {
    try {
      return await _service.fetchBrandFeatures();
    } on ApiException catch (e) {
      debugPrint('[BrandFeaturesRepository] ApiException: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[BrandFeaturesRepository] Unexpected error: $e\n$stack');
      throw ApiException(
        message:
            'Failed to load brand features. Please check your connection and try again.',
      );
    }
  }
}
