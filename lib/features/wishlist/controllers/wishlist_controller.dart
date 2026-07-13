import 'package:get/get.dart';

class WishlistController extends GetxController {
  static const String tag = 'wishlist';

  /// Wishlist items are stored as maps to match current UI.
  /// (name, category, price, image)
  final RxList<Map<String, dynamic>> wishlistItems = <Map<String, dynamic>>[
    {
      "name": "Glow Face Wash",
      "category": "Skin Care",
      "price": "1500",
      "image": "assets/images/banner1.jpeg",
    },
    {
      "name": "Hair Growth Serum",
      "category": "Hair Care",
      "price": "2200",
      "image": "assets/images/banner2.jpeg",
    },
  ].obs;

  bool _isSameProduct(Map<String, dynamic> a, Map<String, dynamic> b) {
    return a['name'] == b['name'] &&
        a['image'] == b['image'] &&
        a['price'] == b['price'];
  }

  bool isInWishlist(Map<String, dynamic> product) {
    for (final item in wishlistItems) {
      if (_isSameProduct(item, product)) return true;
    }
    return false;
  }

  void addToWishlist(Map<String, dynamic> product) {
    // Debug: ensure method is hitting.
    // ignore: avoid_print

    // Ensure correct type (Get may pass IdentityMap internally).
    final normalized = <String, dynamic>{...product};

    if (isInWishlist(normalized)) {
      Get.snackbar(
        'Wishlist',
        'Already saved to wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    wishlistItems.add(normalized);

    Get.snackbar(
      'Wishlist',
      'Saved to wishlist',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void removeItem(int index) {
    wishlistItems.removeAt(index);
  }

  void toggleWishlistItem(Map<String, dynamic> product) {
    final normalized = <String, dynamic>{...product};

    final index = wishlistItems.indexWhere(
      (item) => _isSameProduct(item, normalized),
    );

    if (index != -1) {
      wishlistItems.removeAt(index);
      Get.snackbar(
        'Wishlist',
        'Item removed from wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    addToWishlist(normalized);
  }

  /// Kept for compatibility; used by wishlist UI flow.
  void addToCartDynamic(Map<String, dynamic> product) {
    // Cart integration later
  }

  /// Alias to keep older code compiling
  void addToCartLegacy(Map<String, dynamic> product) {
    // Cart integration later
  }
}
