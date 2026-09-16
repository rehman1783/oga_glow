import 'package:get/get.dart';
import '../../category/controllers/category_controller.dart';

class MainNavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changeIndex(int index, {bool keepFilter = false}) {
    if (index == 1 && !keepFilter) {
      if (Get.isRegistered<CategoryController>()) {
        Get.find<CategoryController>().resetFilter();
      }
    }
    currentIndex.value = index;
  }
}