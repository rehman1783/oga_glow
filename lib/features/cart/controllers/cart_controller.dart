import 'package:get/get.dart';

class CartController extends GetxController {
  static const String tag = 'cart';

  /// Stored as maps to keep UI/product fields flexible.
  /// Expected keys: name, category, price, image
  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;

  bool _isSameProduct(Map<String, dynamic> a, Map<String, dynamic> b) {
    return a['name'] == b['name'] &&
        a['image'] == b['image'] &&
        a['price'] == b['price'];
  }

  bool isInCart(Map<String, dynamic> product) {
    for (final item in cartItems) {
      if (_isSameProduct(item, product)) return true;
    }
    return false;
  }

  void addToCart(Map<String, dynamic> product) {
    final normalized = <String, dynamic>{...product};

    if (isInCart(normalized)) {
      Get.snackbar(
        'Cart',
        'Already added to cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    cartItems.add(normalized);

    Get.snackbar(
      'Cart',
      'Added to cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }
}
