import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/about/models/fake_review_model.dart';
import 'package:oga_glow/features/about/services/fake_review_service.dart';

class FakeReviewRepository {
  final FakeReviewService _service;

  FakeReviewRepository({FakeReviewService? service})
    : _service = service ?? FakeReviewService();

  Future<FakeReviewResponse> getAllFakeReviews() async {
    try {
      return await _service.getAllFakeReviews();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Unable to load customer reviews.');
    }
  }
}
