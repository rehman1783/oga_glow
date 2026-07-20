import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<CartController>(tag: CartController.tag)) {
      Get.put<CartController>(
        CartController(),
        tag: CartController.tag,
        permanent: true,
      );
    }
  }
}
