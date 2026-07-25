import 'package:get/get.dart';
import 'package:oga_glow/data/repositories/product_repository.dart';
import '../controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ProductRepository>()) {
      Get.lazyPut<ProductRepository>(() => ProductRepository());
    }
    Get.lazyPut<CategoryController>(
      () => CategoryController(productRepository: Get.find<ProductRepository>()),
    );
  }
}