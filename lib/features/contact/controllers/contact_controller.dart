import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/core/widgets/custom_snackbar.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';
import 'package:oga_glow/features/contact/repositories/contact_repository.dart';
import 'package:url_launcher/url_launcher.dart';

/// Controller for the Contact Us screen.
///
/// Provides actions for launching WhatsApp, phone dialer, email composer,
/// and external URLs.
class ContactController extends GetxController {
  final ContactRepository _repository;

  ContactController({ContactRepository? repository})
      : _repository = repository ?? ContactRepository();

  final contactInfo = Rx<ContactInfoModel>(ContactInfoModel.fallback());
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
      // Keep fallback so UI remains functional
      if (contactInfo.value.allOffices.isEmpty) {
        contactInfo.value = ContactInfoModel.fallback();
      }
    } catch (_) {
      errorMessage.value = 'Unable to load live contact information.';
      if (contactInfo.value.allOffices.isEmpty) {
        contactInfo.value = ContactInfoModel.fallback();
      }
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
      formError.value = 'Please complete all fields before sending your message.';
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
      CustomSnackbar.showSuccess(
        title: 'Message Sent',
        message: 'Thank you! Your message has been sent successfully.',
      );
    } on ApiException catch (e) {
      formError.value = e.message;
      CustomSnackbar.showError(
        title: 'Submission Error',
        message: e.message,
      );
    } catch (_) {
      formError.value = 'Unable to send your message right now.';
      CustomSnackbar.showError(
        title: 'Submission Error',
        message: 'Unable to send your message right now. Please try again.',
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

  /// Opens the WhatsApp direct chat link.
  Future<void> launchWhatsApp([String? target]) async {
    final raw = target ?? contactInfo.value.effectiveWhatsAppUrl;
    String url = raw;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      final cleanNumber = raw.replaceAll(RegExp(r'[^0-9]'), '');
      url = 'https://wa.me/$cleanNumber';
    }
    await launchUrlString(url);
  }

  /// Opens the phone dialer with the given phone number.
  Future<void> launchPhone(String phone) async {
    final cleanPhone = phone.replaceAll(' ', '').replaceAll('-', '');
    final uriString = cleanPhone.startsWith('tel:') ? cleanPhone : 'tel:$cleanPhone';
    final uri = Uri.parse(uriString);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        CustomSnackbar.showInfo(
          title: 'Dialer Unavailable',
          message: 'Contact: $phone',
        );
      }
    } catch (_) {
      CustomSnackbar.showInfo(
        title: 'Contact Phone',
        message: phone,
      );
    }
  }

  /// Opens the email app with the given email address.
  Future<void> launchEmail(String email) async {
    final cleanEmail = email.trim();
    final uriString = cleanEmail.startsWith('mailto:') ? cleanEmail : 'mailto:$cleanEmail';
    final uri = Uri.parse(uriString);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        CustomSnackbar.showInfo(
          title: 'Email Address',
          message: email,
        );
      }
    } catch (_) {
      CustomSnackbar.showInfo(
        title: 'Email Address',
        message: email,
      );
    }
  }

  /// Opens the given [url] in the default browser.
  Future<void> launchUrlString(String url) async {
    String formattedUrl = url.trim();
    if (!formattedUrl.startsWith('http://') && !formattedUrl.startsWith('https://')) {
      formattedUrl = 'https://$formattedUrl';
    }
    final uri = Uri.parse(formattedUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        CustomSnackbar.showError(
          title: 'Unable to open link',
          message: url,
        );
      }
    } catch (_) {
      CustomSnackbar.showError(
        title: 'Unable to open link',
        message: url,
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

