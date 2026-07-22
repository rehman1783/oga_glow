import 'package:get/get.dart';
import '../controllers/order_controller.dart';

/// Binding for the Orders feature.
///
/// Registers [OrderController] lazily so it is available
/// when the Order History screen is opened.
class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }
}

