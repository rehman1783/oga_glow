import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class QuantitySelector
    extends GetView<ProductController> {
  const QuantitySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed:
                controller
                    .decreaseQuantity,
            icon:
                const Icon(
              Icons.remove,
            ),
          ),

          Text(
            controller.quantity.value
                .toString(),
          ),

          IconButton(
            onPressed:
                controller
                    .increaseQuantity,
            icon:
                const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}