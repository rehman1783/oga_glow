import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';

class CartController extends GetxController {
  static const String tag = 'cart';

  /// Stored as maps to keep UI/product fields flexible.
  /// Expected keys: name, category, price, image, quantity
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

  double _parsePrice(dynamic priceVal) {
    if (priceVal == null) return 0.0;
    final cleaned = priceVal.toString().replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  /// Calculates total subtotal of all items in cart.
  double get totalSubtotal {
    return cartItems.fold<double>(0.0, (sum, item) {
      final price = _parsePrice(item['price']);
      final qty = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      return sum + (price * qty);
    });
  }

  /// Adds product to cart or updates its quantity if already exists.
  /// Returns `true` if item was updated (existed), `false` if newly added.
  bool addToCart(
    Map<String, dynamic> product, {
    int quantity = 1,
    bool showSnackbar = true,
  }) {
    final normalized = <String, dynamic>{
      'name': product['name']?.toString() ?? 'Product',
      'price': product['price']?.toString() ?? '0',
      'image': product['image']?.toString() ?? '',
      'category': product['category']?.toString() ?? 'General',
      'quantity': quantity,
    };

    final existingIndex = cartItems.indexWhere(
      (item) => _isSameProduct(item, normalized),
    );

    final bool isExisting = existingIndex != -1;

    if (isExisting) {
      final currentQty =
          int.tryParse(cartItems[existingIndex]['quantity']?.toString() ?? '1') ??
              1;
      cartItems[existingIndex]['quantity'] = currentQty + quantity;
      cartItems.refresh();
    } else {
      cartItems.add(normalized);
    }

    if (showSnackbar) {
      showSuccessSnackbar(quantity: quantity);
    }

    return isExisting;
  }

  /// Displays success snackbar showing dynamic quantity added to cart.
  void showSuccessSnackbar({
    required int quantity,
    bool isExisting = false,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    final String itemText = quantity == 1 ? 'item' : 'items';
    final String message = '$quantity $itemText added to cart';

    Get.snackbar(
      'Cart',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
    );
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      final currentQty =
          int.tryParse(cartItems[index]['quantity']?.toString() ?? '1') ?? 1;
      cartItems[index]['quantity'] = currentQty + 1;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      final currentQty =
          int.tryParse(cartItems[index]['quantity']?.toString() ?? '1') ?? 1;
      if (currentQty > 1) {
        cartItems[index]['quantity'] = currentQty - 1;
        cartItems.refresh();
      } else {
        removeItem(index);
      }
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
    }
  }
}
