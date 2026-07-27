import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';
import 'package:oga_glow/features/contact/services/contact_service.dart';

class ContactRepository {
  final ContactService _service;

  ContactRepository({ContactService? service})
    : _service = service ?? ContactService();

  Future<ContactInfoModel> getContactInfo() async {
    try {
      return await _service.fetchContactInfo();
    } on ApiException catch (e) {
      debugPrint('[ContactRepository] ApiException: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[ContactRepository] Unexpected error: $e\n$stack');
      throw ApiException(message: 'Unable to load contact information.');
    }
  }

  Future<void> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      await _service.submitContactForm(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );
    } on ApiException catch (e) {
      debugPrint('[ContactRepository] submit contact error: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[ContactRepository] Unexpected contact error: $e\n$stack');
      throw ApiException(
        message: 'Unable to submit your message. Please try again.',
      );
    }
  }
}
