import 'dart:async';

import 'package:get/get.dart';

import 'package:oga_glow/features/auth/controllers/auth_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Wait a bit for splash animation, then check auth state
    Timer(const Duration(seconds: 2), () async {
      final authController = Get.find<AuthController>();
      final initialRoute = await authController.getInitialRoute();
      Get.offAllNamed(initialRoute);
    });
  }
}
