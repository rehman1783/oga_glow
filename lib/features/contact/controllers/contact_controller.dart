import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';
import 'package:oga_glow/features/contact/repositories/contact_repository.dart';
import 'package:url_launcher/url_launcher.dart';

/// Controller for the Contact Us screen.
///
/// Provides actions for launching phone dialer, email, and URLs.
/// Uses [url_launcher] to open external apps.
class ContactController extends GetxController {
  final ContactRepository _repository;

  ContactController({ContactRepository? repository})
    : _repository = repository ?? ContactRepository();

  final contactInfo = Rxn<ContactInfoModel>();
  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final errorMessage = ''.obs;
  final formError = ''.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchContactInfo();
  }

  Future<void> fetchContactInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.getContactInfo();
      contactInfo.value = result;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Unable to load contact information.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitContactForm() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final subject = subjectController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
      formError.value =
          'Please complete all fields before sending your message.';
      return;
    }

    if (!GetUtils.isEmail(email)) {
      formError.value = 'Please enter a valid email address.';
      return;
    }

    try {
      isSubmitting.value = true;
      formError.value = '';
      await _repository.submitContactForm(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );
      clearForm();
      Get.snackbar(
        'Success',
        'Your message was sent successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade700,
        colorText: Colors.white,
      );
    } on ApiException catch (e) {
      formError.value = e.message;
      Get.snackbar(
        'Contact Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
      );
    } catch (e) {
      formError.value = 'Unable to send your message right now.';
      Get.snackbar(
        'Contact Error',
        formError.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    formError.value = '';
  }

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

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
