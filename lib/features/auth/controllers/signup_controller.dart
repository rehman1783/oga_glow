import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 900));
    isLoading.value = false;

    Get.offAllNamed(AppRoutes.mainNavigation);
  }
}
