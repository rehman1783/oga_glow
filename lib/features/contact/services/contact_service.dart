import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';

class ContactService {
  final ApiClient _apiClient;

  ContactService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<ContactInfoModel> fetchContactInfo() async {
    debugPrint('[ContactService] Fetching contact info');
    try {
      final response = await _apiClient.get('/ogaglow/contact-info');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final payload = data['data'] ?? data;
        if (payload is Map<String, dynamic>) {
          return ContactInfoModel.fromJson(payload);
        }
      }
    } catch (e) {
      debugPrint('[ContactService] Fetch contact info failed: $e');
    }

    return ContactInfoModel();
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

    await _apiClient.post('/ogaglow/contact-us', data: payload);
  }
}
