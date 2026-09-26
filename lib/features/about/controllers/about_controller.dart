import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/about/models/about_us_model.dart';
import 'package:oga_glow/features/about/models/customer_review_model.dart';
import 'package:oga_glow/features/about/repositories/about_repository.dart';
import 'package:oga_glow/features/about/repositories/customer_review_repository.dart';
import 'package:oga_glow/features/category/controllers/category_controller.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';
import 'package:oga_glow/features/contact/repositories/contact_repository.dart';
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
  final CustomerReviewRepository _customerReviewRepository;
  final ContactRepository _contactRepository;

  AboutController({
    AboutRepository? repository,
    ReviewRepository? reviewRepository,
    CustomerReviewRepository? customerReviewRepository,
    ContactRepository? contactRepository,
  }) : _repository = repository ?? AboutRepository(),
       _reviewRepository = reviewRepository ?? ReviewRepository(),
       _customerReviewRepository = customerReviewRepository ?? CustomerReviewRepository(),
       _contactRepository = contactRepository ?? ContactRepository();

  // Observable States
  final isLoading = true.obs;
  final isError = false.obs;
  final errorMessage = ''.obs;
  final aboutData = Rxn<AboutUsModel>();
  final testimonials = <ReviewModel>[].obs;
  final isTestimonialsLoading = false.obs;
  final testimonialsError = ''.obs;
  final customerReviews = <CustomerReview>[].obs;
  final isCustomerReviewsLoading = false.obs;
  final customerReviewsError = ''.obs;
  final contactInfo = Rx<ContactInfoModel>(ContactInfoModel.fallback());
  final isContactInfoLoading = false.obs;

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
  void onInit() {
    super.onInit();
    fetchAboutPageData();
  }

  Future<void> fetchAboutPageData({bool forceRefresh = false}) async {
    await Future.wait([
      fetchAboutUs(forceRefresh: forceRefresh),
      getCustomerReviews(forceRefresh: forceRefresh),
      fetchContactInfo(),
    ]);
  }

  Future<void> fetchContactInfo() async {
    try {
      isContactInfoLoading.value = true;
      final info = await _contactRepository.getContactInfo();
      contactInfo.value = info;
    } catch (_) {
      // Keep fallback
    } finally {
      isContactInfoLoading.value = false;
    }
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

  Future<void> getCustomerReviews({bool forceRefresh = false}) async {
    try {
      if (customerReviews.isEmpty) {
        isCustomerReviewsLoading.value = true;
      }
      customerReviewsError.value = '';
      final response = await _customerReviewRepository.getAllCustomerReviews(forceRefresh: forceRefresh);
      customerReviews.assignAll(response.reviews);
    } on ApiException catch (e) {
      if (customerReviews.isEmpty) {
        customerReviewsError.value = e.message;
      }
    } catch (e) {
      if (customerReviews.isEmpty) {
        customerReviewsError.value = 'Unable to load customer reviews.';
      }
    } finally {
      isCustomerReviewsLoading.value = false;
    }
  }

  /// Fetches About Us details from backend API.
  Future<void> fetchAboutUs({bool forceRefresh = false}) async {
    try {
      if (aboutData.value == null) {
        isLoading.value = true;
      }
      isError.value = false;
      errorMessage.value = '';

      final result = await _repository.getAboutUs(forceRefresh: forceRefresh);
      aboutData.value = result;
    } on ApiException catch (e) {
      if (aboutData.value == null) {
        isError.value = true;
        errorMessage.value = e.message;
      }
    } catch (e) {
      if (aboutData.value == null) {
        isError.value = true;
        errorMessage.value =
            'An unexpected error occurred while loading About Us.';
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate to the All Products screen.
  void shopNow() {
    if (Get.isRegistered<MainNavigationController>()) {
      if (Get.isRegistered<CategoryController>()) {
        Get.find<CategoryController>().openCategory("All");
      }
      Get.find<MainNavigationController>().changeIndex(1);
      Get.until((route) => route.isFirst);
    } else {
      Get.offAllNamed(AppRoutes.mainNavigation);
    }
  }

  /// Navigate to the Contact Us screen.
  void contactUs() {
    Get.toNamed(AppRoutes.contact);
  }

  /// Open WhatsApp or phone dialer for expert consultation.
  Future<void> talkToExperts() async {
    await launchWhatsApp();
  }

  /// Launch WhatsApp with support contact
  Future<void> launchWhatsApp([String? target]) async {
    final raw = target ?? contactInfo.value.effectiveWhatsAppUrl;
    String url = raw;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      final cleanNumber = raw.replaceAll(RegExp(r'[^0-9]'), '');
      url = 'https://wa.me/$cleanNumber';
    }
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchPhone();
      }
    } catch (_) {
      await launchPhone();
    }
  }

  /// Launch Phone Dialer using live API phone number
  Future<void> launchPhone([String? targetPhone]) async {
    final phone = targetPhone ?? contactInfo.value.primaryPhone;
    final cleanPhone = phone.replaceAll(' ', '').replaceAll('-', '');
    final uriString = cleanPhone.startsWith('tel:') ? cleanPhone : 'tel:$cleanPhone';
    try {
      final phoneUri = Uri.parse(uriString);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showError('Could not open phone dialer for $phone');
      }
    } catch (_) {
      _showError('Could not open phone dialer for $phone');
    }
  }

  /// Launch Email Client using live API email address
  Future<void> launchEmail([String? targetEmail]) async {
    final email = targetEmail ?? contactInfo.value.primaryEmail;
    final cleanEmail = email.trim();
    final uriString = cleanEmail.startsWith('mailto:')
        ? cleanEmail
        : 'mailto:$cleanEmail?subject=OGAGLOW%20Inquiry';
    try {
      final emailUri = Uri.parse(uriString);
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showError('Could not open email client for $email');
      }
    } catch (_) {
      _showError('Could not open email client for $email');
    }
  }

  /// Navigate to the All Products / Product Listing page.
  void viewProducts() {
    shopNow();
  }

  /// Shows an error snackbar when a launch fails.
  void _showError(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        borderRadius: 14,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
