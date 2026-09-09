import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/about/models/about_us_model.dart';
import 'package:oga_glow/features/about/services/about_service.dart';

/// Repository providing About Us data to the controller layer.
class AboutRepository {
  static AboutUsModel? _cachedAboutUs;
  static DateTime? _cacheTime;
  static const Duration _cacheTtl = Duration(minutes: 10);

  final AboutService _aboutService;

  AboutRepository({AboutService? aboutService})
      : _aboutService = aboutService ?? AboutService();

  /// Fetches About Us data via [AboutService] or returns cached data.
  Future<AboutUsModel> getAboutUs({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cachedAboutUs != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheTtl) {
      debugPrint('[AboutRepository] Returning About Us data from memory cache');
      return _cachedAboutUs!;
    }

    try {
      final data = await _aboutService.fetchAboutUs(forceRefresh: forceRefresh);
      _cachedAboutUs = data;
      _cacheTime = DateTime.now();
      return data;
    } on ApiException catch (e) {
      debugPrint('[AboutRepository] ApiException: ${e.message}');
      if (_cachedAboutUs != null) return _cachedAboutUs!;
      rethrow;
    } catch (e, stack) {
      debugPrint('[AboutRepository] Unexpected error: $e\n$stack');
      if (_cachedAboutUs != null) return _cachedAboutUs!;
      throw ApiException(
        message: 'Failed to load About Us details. Please check your connection and try again.',
      );
    }
  }
}
