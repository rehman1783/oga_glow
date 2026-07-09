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
      appBar: AppBar(title: const Text('Product Details'), centerTitle: true),
      bottomNavigationBar: const ProductActionButtons(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProductImageSection(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    ProductInfoSection(product: controller.product),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              ProductDescriptionSection(
                description:
                    controller.product['description'] ??
                    'No description available',
              ),
              const ProductBenefitsSection(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: const QuantitySelector(),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
