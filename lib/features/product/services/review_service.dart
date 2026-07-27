import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/features/product/models/review_model.dart';

class ReviewService {
  final ApiClient _apiClient;

  ReviewService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<List<ReviewModel>> fetchProductReviews(String productId) async {
    debugPrint('[ReviewService] Fetching reviews for product: $productId');
    try {
      final response = await _apiClient.get(
        '/ogaglow/products/$productId/reviews',
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final payload = data['data'] ?? data['reviews'] ?? data;
        if (payload is List) {
          return payload
              .whereType<Map<String, dynamic>>()
              .map(ReviewModel.fromJson)
              .toList();
        }
        if (payload is Map<String, dynamic>) {
          return [ReviewModel.fromJson(payload)];
        }
      }
      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(ReviewModel.fromJson)
            .toList();
      }
    } catch (e) {
      debugPrint('[ReviewService] Fetch reviews failed: $e');
    }

    return [];
  }

  Future<ReviewModel> createReview({
    required String productId,
    required String name,
    required String email,
    required int rating,
    required String review,
  }) async {
    debugPrint('[ReviewService] Creating review for product: $productId');
    final payload = {
      'productId': productId,
      'name': name.trim(),
      'email': email.trim(),
      'rating': rating,
      'review': review.trim(),
    };

    final response = await _apiClient.post(
      '/ogaglow/reviews/create',
      data: payload,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      final reviewData = data['data'] ?? data['review'] ?? data;
      if (reviewData is Map<String, dynamic>) {
        return ReviewModel.fromJson(reviewData);
      }
    }

    return ReviewModel(
      name: name,
      email: email,
      rating: rating,
      review: review,
      productId: productId,
    );
  }

  Future<List<ReviewModel>> fetchFakeTestimonials() async {
    debugPrint('[ReviewService] Fetching fake reviews/testimonials');
    try {
      final response = await _apiClient.get('/ogaglow/about-us');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final reviews = data['reviews'] ?? data['testimonials'] ?? data['data'];
        if (reviews is List) {
          return reviews
              .whereType<Map<String, dynamic>>()
              .map(ReviewModel.fromJson)
              .toList();
        }
      }
    } catch (e) {
      debugPrint('[ReviewService] Fetch testimonials failed: $e');
    }
    return [];
  }
}
