import 'package:get/get.dart';

class ProductController extends GetxController {
  final quantity = 1.obs;
  final currentImageIndex = 0.obs;

final productImages = [
  'assets/images/banner1.jpeg',
  'assets/images/banner2.jpeg',
  'assets/images/banner3.jpeg',
].obs;

void changeImage(int index) {
  currentImageIndex.value = index;
}

  late Map<String, dynamic> product;

  @override
  void onInit() {
    super.onInit();

    product = Get.arguments ?? {};
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}