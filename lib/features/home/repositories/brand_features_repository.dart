import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/home/models/brand_features_model.dart';
import 'package:oga_glow/features/home/services/brand_features_service.dart';

class BrandFeaturesRepository {
  static BrandFeaturesModel? _cachedFeatures;
  static DateTime? _cacheTime;
  static const Duration _cacheTtl = Duration(minutes: 5);

  final BrandFeaturesService _service;

  BrandFeaturesRepository({BrandFeaturesService? service})
    : _service = service ?? BrandFeaturesService();

  Future<BrandFeaturesModel> getBrandFeatures({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cachedFeatures != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheTtl) {
      debugPrint('[BrandFeaturesRepository] Returning brand features from memory cache');
      return _cachedFeatures!;
    }

    try {
      final features = await _service.fetchBrandFeatures(forceRefresh: forceRefresh);
      _cachedFeatures = features;
      _cacheTime = DateTime.now();
      return features;
    } on ApiException catch (e) {
      debugPrint('[BrandFeaturesRepository] ApiException: ${e.message}');
      if (_cachedFeatures != null) return _cachedFeatures!;
      rethrow;
    } catch (e, stack) {
      debugPrint('[BrandFeaturesRepository] Unexpected error: $e\n$stack');
      if (_cachedFeatures != null) return _cachedFeatures!;
      throw ApiException(
        message:
            'Failed to load brand features. Please check your connection and try again.',
      );
    }
  }
}
