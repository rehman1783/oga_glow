import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oga_glow/data/models/product_model.dart';
import '../../../core/theme/app_colors.dart';

class CartController extends GetxController {
  static const String tag = 'cart';
  static const String _storageKey = 'local_cart_items_v1';

  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCartFromStorage();

    // Automatically persist to SharedPreferences whenever cartItems changes
    ever(cartItems, (_) {
      _saveCartToStorage();
    });
  }

  /// Loads cart items from SharedPreferences on initialization
  Future<void> _loadCartFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_storageKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(jsonString);
        final loadedItems = decoded.map<Map<String, dynamic>>((e) {
          final map = Map<String, dynamic>.from(e as Map);
          if (map['productModel'] != null && map['productModel'] is Map) {
            map['productModel'] = ProductModel.fromJson(
              Map<String, dynamic>.from(map['productModel'] as Map),
            );
          }
          return map;
        }).toList();
        cartItems.assignAll(loadedItems);
      }
    } catch (e) {
      debugPrint('[CartController] Error loading cart from storage: $e');
    }
  }

  /// Saves cart items to SharedPreferences
  Future<void> _saveCartToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> serializableList = cartItems.map((item) {
        final Map<String, dynamic> itemMap = Map<String, dynamic>.from(item);
        if (itemMap['productModel'] is ProductModel) {
          itemMap['productModel'] = (itemMap['productModel'] as ProductModel).toJson();
        }
        return itemMap;
      }).toList();
      final String jsonString = jsonEncode(serializableList);
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      debugPrint('[CartController] Error saving cart to storage: $e');
    }
  }

  bool _isSameProduct(Map<String, dynamic> a, Map<String, dynamic> b) {
    if (a['id'] != null && b['id'] != null && a['id'].toString().isNotEmpty && b['id'].toString().isNotEmpty) {
      return a['id'].toString() == b['id'].toString();
    }
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

  /// Calculates total subtotal (sum of item price * qty)
  double get totalSubtotal {
    return cartItems.fold<double>(0.0, (sum, item) {
      final price = _parsePrice(item['price']);
      final qty = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      return sum + (price * qty);
    });
  }

  /// Calculates total shipping cost
  double get totalShipping {
    return cartItems.fold<double>(0.0, (sum, item) {
      final model = item['productModel'];
      if (model is ProductModel) {
        return sum + model.shippingPrice;
      }
      final ship = _parsePrice(item['shippingPrice']);
      return sum + ship;
    });
  }

  /// Calculates total tax amount
  double get totalTax {
    return cartItems.fold<double>(0.0, (sum, item) {
      final price = _parsePrice(item['price']);
      final qty = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      final model = item['productModel'];
      final taxRate = (model is ProductModel) ? model.taxRate : _parsePrice(item['taxRate']);
      return sum + (price * qty * taxRate);
    });
  }

  /// Calculates total discount amount saved
  double get totalDiscount {
    return cartItems.fold<double>(0.0, (sum, item) {
      final origPrice = _parsePrice(item['originalPrice']);
      final finalPrice = _parsePrice(item['price']);
      final qty = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      if (origPrice > finalPrice) {
        return sum + ((origPrice - finalPrice) * qty);
      }
      return sum;
    });
  }

  /// Grand Total = Subtotal + Shipping + Tax
  double get grandTotal {
    return totalSubtotal + totalShipping + totalTax;
  }

  /// Adds product to cart or updates quantity
  bool addToCart(
    Map<String, dynamic> product, {
    int quantity = 1,
    bool showSnackbar = true,
  }) {
    final normalized = <String, dynamic>{
      'id': product['id']?.toString() ?? '',
      'name': product['name']?.toString() ?? 'Product',
      'price': product['price']?.toString() ?? '0',
      'originalPrice': product['originalPrice']?.toString() ?? product['price']?.toString() ?? '0',
      'image': product['image']?.toString() ?? '',
      'category': product['category']?.toString() ?? 'General',
      'productModel': product['productModel'],
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
      snackPosition: SnackPosition.TOP,
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

  void clearCart() {
    cartItems.clear();
  }
}
