import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:oga_glow/features/cart/controllers/cart_controller.dart';
import 'package:oga_glow/features/category/controllers/category_controller.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';
import 'package:oga_glow/features/wishlist/controllers/wishlist_controller.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavigationController());
    Get.put(HomeController());
    Get.put(CategoryController());
    Get.lazyPut<CartController>(
      () => CartController(),
      tag: CartController.tag,
    );
Get.put(
  WishlistController(),
  tag: WishlistController.tag,
  permanent: true,
);  }
}
