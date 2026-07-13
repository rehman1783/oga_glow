import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Demo cart items (until Cart module connects)
  final cartItems = <Map<String, dynamic>>[
    {'name': 'Glow Serum', 'price': '799'},
    {'name': 'Herbal Moisturizer', 'price': '599'},
  ].obs;

  final paymentMethod = 'card'.obs; // 'card' | 'cod'

  // Address fields
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  int get total => cartItems.fold<int>(0, (sum, item) {
        final p = int.tryParse(item['price']?.toString() ?? '') ?? 0;
        return sum + p;
      });

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

