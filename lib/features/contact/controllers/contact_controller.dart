import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

/// Controller for the Contact Us screen.
///
/// Provides actions for launching phone dialer, email, and URLs.
/// Uses [url_launcher] to open external apps.
class ContactController extends GetxController {
  /// Opens the phone dialer with the given [phoneUrl].
  /// [phoneUrl] should be a `tel:` URI (e.g., `tel:+923213270507`).
  Future<void> launchPhone(String phoneUrl) async {
    final uri = Uri.parse(phoneUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showError('Could not open dialer for $phoneUrl');
    }
  }

  /// Opens the email app with the given [emailUrl].
  /// [emailUrl] should be a `mailto:` URI.
  Future<void> launchEmail(String emailUrl) async {
    final uri = Uri.parse(emailUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showError('Could not open email app');
    }
  }

  /// Opens the given [url] in the default browser.
  Future<void> launchUrlString(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showError('Could not open $url');
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
