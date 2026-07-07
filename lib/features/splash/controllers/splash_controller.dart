import 'dart:async';

import 'package:get/get.dart';
import 'package:oga_glow/core/routes/app_routes.dart';



class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }
}