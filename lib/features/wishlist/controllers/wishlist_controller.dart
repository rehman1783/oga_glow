import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/widgets/add_to_cart_bottom_sheet.dart';

class WishlistController extends GetxController {
  static const String tag = 'wishlist';

  /// Wishlist items stored dynamically from API product data.
  final RxList<Map<String, dynamic>> wishlistItems = <Map<String, dynamic>>[].obs;

  bool _isSameProduct(Map<String, dynamic> a, Map<String, dynamic> b) {
    if (a['id'] != null && b['id'] != null && a['id'].toString().isNotEmpty && b['id'].toString().isNotEmpty) {
      return a['id'].toString() == b['id'].toString();
    }
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
    if (index >= 0 && index < wishlistItems.length) {
      wishlistItems.removeAt(index);
    }
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
