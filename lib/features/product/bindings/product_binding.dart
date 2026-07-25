import 'package:get/get.dart';
import 'package:oga_glow/data/repositories/product_repository.dart';
import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<ProductController>(
      () => ProductController(productRepository: Get.find<ProductRepository>()),
    );
  }
}