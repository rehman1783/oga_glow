import 'package:get/get.dart';

import '../controllers/auth_entry_controller.dart';

class AuthEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthEntryController>(() => AuthEntryController());
  }
}

