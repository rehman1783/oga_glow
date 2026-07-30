import 'package:get/get.dart';

import 'package:oga_glow/data/repositories/product_repository.dart';
import 'package:oga_glow/features/home/repositories/brand_features_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<BrandFeaturesRepository>(() => BrandFeaturesRepository());
    Get.lazyPut<HomeController>(
      () => HomeController(
        productRepository: Get.find<ProductRepository>(),
        brandFeaturesRepository: Get.find<BrandFeaturesRepository>(),
      ),
    );
  }
}
