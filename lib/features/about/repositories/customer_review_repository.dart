import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/about/models/customer_review_model.dart';
import 'package:oga_glow/features/about/services/customer_review_service.dart';

class CustomerReviewRepository {
  static CustomerReviewResponse? _cachedResponse;
  static DateTime? _cacheTime;
  static const Duration _cacheTtl = Duration(minutes: 10);

  final CustomerReviewService _service;

  CustomerReviewRepository({CustomerReviewService? service})
    : _service = service ?? CustomerReviewService();

  Future<CustomerReviewResponse> getAllCustomerReviews({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cachedResponse != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheTtl) {
      return _cachedResponse!;
    }

    try {
      final res = await _service.getAllCustomerReviews();
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
