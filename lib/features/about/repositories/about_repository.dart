import 'package:flutter/foundation.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/about/models/about_us_model.dart';
import 'package:oga_glow/features/about/services/about_service.dart';

/// Repository providing About Us data to the controller layer.
class AboutRepository {
  final AboutService _aboutService;

  AboutRepository({AboutService? aboutService})
      : _aboutService = aboutService ?? AboutService();

  /// Fetches About Us data via [AboutService] and handles errors.
  Future<AboutUsModel> getAboutUs() async {
    try {
      return await _aboutService.fetchAboutUs();
    } on ApiException catch (e) {
      debugPrint('[AboutRepository] ApiException: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('[AboutRepository] Unexpected error: $e\n$stack');
      throw ApiException(
        message: 'Failed to load About Us details. Please check your connection and try again.',
      );
    }
  }
}
