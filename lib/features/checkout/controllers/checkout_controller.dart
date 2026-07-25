import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/cart/controllers/cart_controller.dart';
import 'package:oga_glow/features/cart/bindings/cart_binding.dart';

class CheckoutController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final paymentMethod = 'card'.obs; // 'card' | 'cod'

  // Address fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  CartController get _cartController {
    if (!Get.isRegistered<CartController>(tag: CartController.tag)) {
      CartBinding().dependencies();
    }
    return Get.find<CartController>(tag: CartController.tag);
  }

  List<Map<String, dynamic>> get cartItems => _cartController.cartItems;

  double get subtotal => _cartController.totalSubtotal;
  double get shipping => _cartController.totalShipping;
  double get tax => _cartController.totalTax;
  double get discount => _cartController.totalDiscount;
  double get grandTotal => _cartController.grandTotal;

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    super.onClose();
  }

  void setPaymentMethod(String v) => paymentMethod.value = v;
}
