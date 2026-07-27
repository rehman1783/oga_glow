import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/product/models/review_model.dart';
import 'package:oga_glow/features/product/services/review_service.dart';

class ReviewRepository {
  final ReviewService _service;

  ReviewRepository({ReviewService? service})
    : _service = service ?? ReviewService();

  Future<List<ReviewModel>> getProductReviews(String productId) async {
    try {
      return await _service.fetchProductReviews(productId);
    } on ApiException catch (e) {
      debugPrint('[ReviewRepository] ApiException: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[ReviewRepository] Unexpected error: $e\n$stack');
      throw ApiException(message: 'Unable to load reviews right now.');
    }
  }

  Future<ReviewModel> createReview({
    required String productId,
    required String name,
    required String email,
    required int rating,
    required String review,
  }) async {
    try {
      return await _service.createReview(
        productId: productId,
        name: name,
        email: email,
        rating: rating,
        review: review,
      );
    } on ApiException catch (e) {
      debugPrint('[ReviewRepository] create review error: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[ReviewRepository] Unexpected review error: $e\n$stack');
      throw ApiException(
        message: 'Unable to submit your review. Please try again.',
      );
    }
  }

  Future<List<ReviewModel>> getFakeTestimonials() async {
    try {
      return await _service.fetchFakeTestimonials();
    } on ApiException catch (e) {
      debugPrint('[ReviewRepository] Fake review error: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[ReviewRepository] Unexpected fake review error: $e\n$stack');
      throw ApiException(message: 'Unable to load testimonials right now.');
    }
  }
}
