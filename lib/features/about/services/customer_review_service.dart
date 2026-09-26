import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/features/about/models/customer_review_model.dart';

class CustomerReviewService {
  final ApiClient _apiClient;

  CustomerReviewService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<CustomerReviewResponse> getAllCustomerReviews() async {
    debugPrint('[CustomerReviewService] Fetching all customer reviews');
    final response = await _apiClient.get(
      '/OGAGLOW/fake-reviews/getAllFakeReviews',
    );
    final data = response.data;

    if (data is Map<String, dynamic>) {
      return CustomerReviewResponse.fromJson(data);
    }

    return CustomerReviewResponse(success: false, reviews: []);
  }
}
