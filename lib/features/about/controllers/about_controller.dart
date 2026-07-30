import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/about/models/about_us_model.dart';
import 'package:oga_glow/features/about/models/fake_review_model.dart';
import 'package:oga_glow/features/about/repositories/about_repository.dart';
import 'package:oga_glow/features/about/repositories/fake_review_repository.dart';
import 'package:oga_glow/features/category/controllers/category_controller.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';
import 'package:oga_glow/features/product/models/review_model.dart';
import 'package:oga_glow/features/product/repositories/review_repository.dart';
import 'package:url_launcher/url_launcher.dart';

/// Controller for the About Us screen.
///
/// Manages API state (Loading, Success, Error, Empty) using GetX observables
/// and handles navigation/external launcher actions.
class AboutController extends GetxController {
  final AboutRepository _repository;
  final ReviewRepository _reviewRepository;
  final FakeReviewRepository _fakeReviewRepository;

  AboutController({
    AboutRepository? repository,
    ReviewRepository? reviewRepository,
    FakeReviewRepository? fakeReviewRepository,
  }) : _repository = repository ?? AboutRepository(),
       _reviewRepository = reviewRepository ?? ReviewRepository(),
       _fakeReviewRepository = fakeReviewRepository ?? FakeReviewRepository();

  // Observable States
  final isLoading = true.obs;
  final isError = false.obs;
  final errorMessage = ''.obs;
  final aboutData = Rxn<AboutUsModel>();
  final testimonials = <ReviewModel>[].obs;
  final isTestimonialsLoading = false.obs;
  final testimonialsError = ''.obs;
  final fakeReviews = <FakeReview>[].obs;
  final isFakeReviewsLoading = false.obs;
  final fakeReviewsError = ''.obs;

  /// Helper getter to check if FAQ list is empty
  bool get isFaqEmpty {
    final faqs = aboutData.value?.faq;
    return faqs == null || faqs.isEmpty;
  }

  /// Helper getter to check if entire data is empty
  bool get isEmptyState {
    final data = aboutData.value;
    if (data == null) return true;
    final banner = data.banner;
    final hasBannerText =
        banner?.paragraph?.isNotEmpty == true ||
        banner?.card1?.isNotEmpty == true ||
        banner?.card2?.isNotEmpty == true ||
        banner?.card3?.isNotEmpty == true;
    final hasImages =
        data.firstImage?.isNotEmpty == true ||
        data.secondImage?.isNotEmpty == true ||
        data.faqImage?.isNotEmpty == true;
    final hasFaq = data.faq != null && data.faq!.isNotEmpty;
    return !hasBannerText && !hasImages && !hasFaq;
  }

  @override
  @override
  void onInit() {
    super.onInit();
    fetchAboutUs();
    getFakeReviews();
  }

  Future<void> fetchTestimonials() async {
    try {
      isTestimonialsLoading.value = true;
      testimonialsError.value = '';
      final result = await _reviewRepository.getFakeTestimonials();
      testimonials.assignAll(result);
    } on ApiException catch (e) {
      testimonialsError.value = e.message;
    } catch (e) {
      testimonialsError.value = 'Unable to load testimonials.';
    } finally {
      isTestimonialsLoading.value = false;
    }
  }

  Future<void> getFakeReviews() async {
    try {
      isFakeReviewsLoading.value = true;
      fakeReviewsError.value = '';
      final response = await _fakeReviewRepository.getAllFakeReviews();
      fakeReviews.assignAll(response.reviews);
    } on ApiException catch (e) {
      fakeReviewsError.value = e.message;
    } catch (e) {
      fakeReviewsError.value = 'Unable to load customer reviews.';
    } finally {
      isFakeReviewsLoading.value = false;
    }
  }

  /// Fetches About Us details from backend API.
  Future<void> fetchAboutUs() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final result = await _repository.getAboutUs();
      aboutData.value = result;
    } on ApiException catch (e) {
      isError.value = true;
      errorMessage.value = e.message;
    } catch (e) {
      isError.value = true;
      errorMessage.value =
          'An unexpected error occurred while loading About Us.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate to the All Products screen.
  void shopNow() {
    if (Get.isRegistered<CategoryController>() &&
        Get.isRegistered<MainNavigationController>()) {
      final categoryController = Get.find<CategoryController>();
      final mainNavController = Get.find<MainNavigationController>();
      categoryController.openCategory("All");
      mainNavController.changeIndex(1);
    }
  }

  /// Navigate to the Contact Us screen.
  void contactUs() {
    Get.toNamed(AppRoutes.contact);
  }

  /// Open WhatsApp or phone dialer for expert consultation.
  Future<void> talkToExperts() async {
    final uri = Uri.parse(AboutConstants.whatsappUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final phoneUri = Uri.parse(AboutConstants.phoneDial);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showError('Could not open dialer or WhatsApp');
      }
    }
  }

  /// Navigate to the All Products / Product Listing page.
  void viewProducts() {
    if (Get.isRegistered<CategoryController>() &&
        Get.isRegistered<MainNavigationController>()) {
      final categoryController = Get.find<CategoryController>();
      final mainNavController = Get.find<MainNavigationController>();
      categoryController.openCategory("All");
      mainNavController.changeIndex(1);
    }
  }

  /// Shows an error snackbar when a launch fails.
  void _showError(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        borderRadius: 14,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
