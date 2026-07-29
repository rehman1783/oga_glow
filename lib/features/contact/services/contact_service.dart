import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';

class ContactService {
  final ApiClient _apiClient;

  ContactService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<ContactInfoModel> fetchContactInfo() async {
    debugPrint('[ContactService] Fetching contact info');
    try {
      final response = await _apiClient.get('/settings/contactinfo');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final payload = data['data'] ?? data;
        if (payload is Map<String, dynamic>) {
          return ContactInfoModel.fromJson(payload);
        }
      }
      if (data is List) {
        final payload = data.firstWhere(
          (item) => item is Map<String, dynamic>,
          orElse: () => null,
        );
        if (payload is Map<String, dynamic>) {
          return ContactInfoModel.fromJson(payload);
        }
      }
    } on ApiException catch (e) {
      debugPrint('[ContactService] Fetch contact info failed: ${e.message}');
    } catch (e) {
      debugPrint('[ContactService] Fetch contact info failed: $e');
    }

    return ContactInfoModel.fallback();
  }

  Future<void> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    debugPrint('[ContactService] Submitting contact form');
    final payload = {
      'name': name.trim(),
      'email': email.trim(),
      'subject': subject.trim(),
      'message': message.trim(),
    };

    try {
      await _apiClient.post('/ogaglow/contact-us', data: payload);
    } on ApiException catch (e) {
      debugPrint('[ContactService] Submit contact form failed: ${e.message}');
      rethrow;
    }
  }
}
