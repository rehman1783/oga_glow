import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/product_controller.dart';

class ProductActionButtons extends GetView<ProductController> {
  const ProductActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final cartController = Get.find<CartController>(
                  tag: CartController.tag,
                );
                cartController.addToCart({...controller.product});
              },
              child: const Text('Add To Cart'),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Buy Now'),
            ),
          ),
        ],
      ),
    );
  }
}
