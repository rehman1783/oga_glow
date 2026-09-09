import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:oga_glow/data/repositories/product_repository.dart';
import 'package:oga_glow/features/about/repositories/about_repository.dart';
import 'package:oga_glow/features/auth/controllers/auth_controller.dart';
import 'package:oga_glow/features/home/repositories/brand_features_repository.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Pre-warm core catalog & brand APIs during splash animation
    unawaited(_prewarmData());

    // Allow graceful entrance animation, then transition
    Timer(const Duration(milliseconds: 2500), () async {
      final authController = Get.find<AuthController>();
      final initialRoute = await authController.getInitialRoute();
      Get.offAllNamed(initialRoute);
    });
  }

  Future<void> _prewarmData() async {
    try {
      debugPrint('[SplashController] Pre-warming app data in background...');
      await Future.wait([
        ProductRepository().getProducts(),
        BrandFeaturesRepository().getBrandFeatures(),
        AboutRepository().getAboutUs(),
      ]);
      debugPrint('[SplashController] App data successfully pre-warmed!');
    } catch (e) {
      debugPrint('[SplashController] Pre-warming non-critical error: $e');
    }
  }
}
