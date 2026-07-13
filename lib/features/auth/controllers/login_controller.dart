import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    // TODO: connect with API/auth repo.
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;

    Get.offAllNamed(AppRoutes.mainNavigation);
  }
}
