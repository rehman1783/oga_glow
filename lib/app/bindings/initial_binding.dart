import 'package:get/get.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavigationController(), permanent: true);
    // Global dependencies yahan register hongi.
  }
}
