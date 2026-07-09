import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class ProductController extends GetxController {
  final quantity = 1.obs;
  final currentImageIndex = 0.obs;

  final productImages = [
    'assets/images/banner1.jpeg',
    'assets/images/banner2.jpeg',
    'assets/images/banner3.jpeg',
  ].obs;

  // Used by ProductImageSection.
  final pageController = PageController(initialPage: 0);

  void changeImage(int index) {
    currentImageIndex.value = index;
  }

  late Map<String, dynamic> product;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments ?? {};

    // If the route passes a single image, make it first.
    final imageFromArgs = product['image']?.toString();
    if (imageFromArgs != null && imageFromArgs.isNotEmpty) {
      productImages.insert(0, imageFromArgs);
      // De-dupe while preserving order.
      final seen = <String>{};
      productImages.value = productImages.where((e) {
        if (seen.contains(e)) return false;
        seen.add(e);
        return true;
      }).toList();
    }
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // Auto change images when details screen opens.
  @override
  void onReady() {
    super.onReady();
    _startAutoPlay();
  }

  @override
  void onClose() {
    _autoPlayTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  int _autoImageIndex = 0;
  Timer? _autoPlayTimer;

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoImageIndex = currentImageIndex.value;

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (productImages.isEmpty) return;
      _autoImageIndex = (_autoImageIndex + 1) % productImages.length;
      currentImageIndex.value = _autoImageIndex;
      pageController.animateToPage(
        _autoImageIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }
}

