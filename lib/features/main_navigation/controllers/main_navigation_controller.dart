import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../category/controllers/category_controller.dart';

class MainNavigationController extends GetxController {
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _handleInitialTab();
  }

  void _handleInitialTab() {
    final route = Get.currentRoute;
    final args = Get.arguments;

    if (args is int && args >= 0 && args <= 3) {
      changeIndex(args);
    } else if (route == AppRoutes.category || route == AppRoutes.allProducts) {
      changeIndex(1);
    } else if (route == AppRoutes.wishlist) {
      changeIndex(2);
    } else if (route == AppRoutes.cart) {
      changeIndex(3);
    } else if (route == AppRoutes.home) {
      changeIndex(0);
    }
  }

  void changeIndex(int index, {bool keepFilter = false}) {
    if (index == 1 && !keepFilter) {
      if (Get.isRegistered<CategoryController>()) {
        Get.find<CategoryController>().resetFilter();
      }
    }
    currentIndex.value = index;
  }
}