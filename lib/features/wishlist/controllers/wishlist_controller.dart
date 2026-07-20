import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/widgets/add_to_cart_bottom_sheet.dart';

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
      "description":
          "A gentle face wash that helps cleanse, refresh, and support a healthy glow.",
    },
    {
      "name": "Hair Growth Serum",
      "category": "Hair Care",
      "price": "2200",
      "image": "assets/images/banner2.jpeg",
      "description":
          "A lightweight serum formulated to nourish hair and support the appearance of stronger growth.",
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

  /// Used by wishlist UI flow. Opens the quantity selector bottom sheet.
  void addToCartDynamic(BuildContext context, Map<String, dynamic> product) {
    final normalized = <String, dynamic>{...product};
    AddToCartBottomSheet.show(context, normalized);
  }

  /// Alias to keep older code compiling
  void addToCartLegacy(BuildContext context, Map<String, dynamic> product) {
    addToCartDynamic(context, product);
  }
}
