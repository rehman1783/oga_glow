import 'package:get/get.dart';
import 'package:oga_glow/features/product/controllers/product_reviews_controller.dart';
import 'package:oga_glow/features/product/repositories/review_repository.dart';
import 'package:oga_glow/features/product/services/review_service.dart';

class ProductReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewService>(() => ReviewService());
    Get.lazyPut<ReviewRepository>(
      () => ReviewRepository(service: Get.find<ReviewService>()),
    );
    Get.lazyPut<ProductReviewsController>(
      () => ProductReviewsController(
        reviewRepository: Get.find<ReviewRepository>(),
      ),
    );
  }
}
