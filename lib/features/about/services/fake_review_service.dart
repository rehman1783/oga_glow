import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/features/about/models/fake_review_model.dart';

class FakeReviewService {
  final ApiClient _apiClient;

  FakeReviewService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<FakeReviewResponse> getAllFakeReviews() async {
    debugPrint('[FakeReviewService] Fetching all fake reviews');
    final response = await _apiClient.get(
      '/ogaglow/fake-reviews/getAllFakeReviews',
    );
    final data = response.data;

    if (data is Map<String, dynamic>) {
      return FakeReviewResponse.fromJson(data);
    }

    return FakeReviewResponse(success: false, reviews: []);
  }
}
