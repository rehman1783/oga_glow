import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/product/widgets/product_image_slider.dart';

import '../controllers/product_controller.dart';
import '../widgets/product_action_buttons.dart';
import '../widgets/product_benefits_section.dart';
import '../widgets/product_description_section.dart';
import '../widgets/product_info_section.dart';
import '../widgets/quantity_selector.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller;

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),

      bottomNavigationBar: const ProductActionButtons(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProductImageSection(),

            ProductInfoSection(product: controller.product),

            ProductDescriptionSection(
              description:
                  controller.product['description'] ??
                  'No description available',
            ),

            const ProductBenefitsSection(),

            const QuantitySelector(),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
