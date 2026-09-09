import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/about/models/fake_review_model.dart';
import 'package:oga_glow/features/about/services/fake_review_service.dart';

class FakeReviewRepository {
  static FakeReviewResponse? _cachedResponse;
  static DateTime? _cacheTime;
  static const Duration _cacheTtl = Duration(minutes: 10);

  final FakeReviewService _service;

  FakeReviewRepository({FakeReviewService? service})
    : _service = service ?? FakeReviewService();

  Future<FakeReviewResponse> getAllFakeReviews({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cachedResponse != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheTtl) {
      return _cachedResponse!;
    }

    try {
      final res = await _service.getAllFakeReviews();
      _cachedResponse = res;
      _cacheTime = DateTime.now();
      return res;
    } on ApiException {
      if (_cachedResponse != null) return _cachedResponse!;
      rethrow;
    } catch (e) {
      if (_cachedResponse != null) return _cachedResponse!;
      throw ApiException(message: 'Unable to load customer reviews.');
    }
  }
}
