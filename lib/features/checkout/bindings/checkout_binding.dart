import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';
import '../repositories/checkout_repository.dart';
import '../services/checkout_service.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutService>(() => CheckoutService());
    Get.lazyPut<CheckoutRepository>(
      () => CheckoutRepository(service: Get.find<CheckoutService>()),
    );
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(
        checkoutRepository: Get.find<CheckoutRepository>(),
      ),
    );
  }
}

