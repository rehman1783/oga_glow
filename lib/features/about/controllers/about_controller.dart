import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/category/controllers/category_controller.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/constants/about_constants.dart';

/// Controller for the About Us screen.
///
/// Provides navigation actions for CTA buttons and utility methods
/// for launching external apps.
class AboutController extends GetxController {
  /// Navigate to the All Products screen.
  void shopNow() {
   final categoryController = Get.find<CategoryController>();
final mainNavController = Get.find<MainNavigationController>();

categoryController.openCategory("All");
mainNavController.changeIndex(1);
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
      // Fallback to phone dialer
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
   final categoryController = Get.find<CategoryController>();
final mainNavController = Get.find<MainNavigationController>();

categoryController.openCategory("All");
mainNavController.changeIndex(1);
  }

  /// Shows an error snackbar when a launch fails.
  void _showError(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
        borderRadius: 14,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
