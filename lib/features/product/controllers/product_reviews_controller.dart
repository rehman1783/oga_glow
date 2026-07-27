import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/product/models/review_model.dart';
import 'package:oga_glow/features/product/repositories/review_repository.dart';

class ProductReviewsController extends GetxController {
  final ReviewRepository _reviewRepository;

  ProductReviewsController({ReviewRepository? reviewRepository})
    : _reviewRepository = reviewRepository ?? ReviewRepository();

  final reviews = <ReviewModel>[].obs;
  final isReviewsLoading = false.obs;
  final isSubmittingReview = false.obs;
  final reviewsError = ''.obs;
  final reviewFormError = ''.obs;

  final rating = 0.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final reviewController = TextEditingController();

  String? productId;

  void setProductId(String? id) {
    productId = id;
  }

  Future<void> loadReviews(String? id) async {
    final targetId = id ?? productId;
    if (targetId == null || targetId.isEmpty) return;

    try {
      isReviewsLoading.value = true;
      reviewsError.value = '';
      final result = await _reviewRepository.getProductReviews(targetId);
      reviews.assignAll(result);
    } on ApiException catch (e) {
      reviewsError.value = e.message;
    } catch (e) {
      reviewsError.value = 'Unable to load reviews.';
    } finally {
      isReviewsLoading.value = false;
    }
  }

  Future<void> submitReview() async {
    final targetId = productId;
    if (targetId == null || targetId.isEmpty) {
      reviewFormError.value = 'Product could not be identified.';
      return;
    }

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final text = reviewController.text.trim();

    if (name.isEmpty || email.isEmpty || text.isEmpty || rating.value == 0) {
      reviewFormError.value =
          'Please fill in your name, email, review, and select a rating.';
      return;
    }

    if (!GetUtils.isEmail(email)) {
      reviewFormError.value = 'Please enter a valid email address.';
      return;
    }

    try {
      isSubmittingReview.value = true;
      reviewFormError.value = '';
      await _reviewRepository.createReview(
        productId: targetId,
        name: name,
        email: email,
        rating: rating.value,
        review: text,
      );
      Get.snackbar(
        'Success',
        'Your review has been submitted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade700,
        colorText: Colors.white,
      );
      clearForm();
      await loadReviews(targetId);
    } on ApiException catch (e) {
      reviewFormError.value = e.message;
      Get.snackbar(
        'Review Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
      );
    } catch (e) {
      reviewFormError.value = 'Unable to submit your review right now.';
      Get.snackbar(
        'Review Error',
        reviewFormError.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
      );
    } finally {
      isSubmittingReview.value = false;
    }
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    reviewController.clear();
    rating.value = 0;
    reviewFormError.value = '';
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    reviewController.dispose();
    super.onClose();
  }
}
