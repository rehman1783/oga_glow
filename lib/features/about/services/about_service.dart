import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/core/network/api_endpoints.dart';
import 'package:oga_glow/features/about/models/about_us_model.dart';

/// Handles raw API calls for the About Us feature.
class AboutService {
  final ApiClient _apiClient;

  AboutService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  /// Fetches About Us data from GET /ogaglow/about-us endpoint.
  Future<AboutUsModel> fetchAboutUs() async {
    debugPrint('[AboutService] Fetching About Us data...');
    final response = await _apiClient.get(ApiEndpoints.aboutUs);

    debugPrint('[AboutService] Response received: ${response.statusCode}');
    if (response.data is Map<String, dynamic>) {
      return AboutUsModel.fromJson(response.data as Map<String, dynamic>);
    }
    throw Exception('Failed to load About Us data: Invalid format');
  }
}
