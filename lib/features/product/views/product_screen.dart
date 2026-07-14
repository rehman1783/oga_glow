import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/product/widgets/product_image_slider.dart';

import '../controllers/product_controller.dart';

import '../widgets/product_action_buttons.dart';
import '../widgets/product_benefits_section.dart';
import '../widgets/product_description_section.dart';
import '../widgets/product_info_section.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/related_products_section.dart';
import '../../../core/widgets/fade_slide_transition.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBar: const ProductActionButtons(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FadeSlideTransition(index: 0, child: const ProductImageSection()),

              FadeSlideTransition(
                index: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
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
                ),
              ),

              FadeSlideTransition(
                index: 2,
                child: ProductDescriptionSection(
                  description:
                      controller.product['description'] ??
                      'No description available',
                ),
              ),

              FadeSlideTransition(
                index: 3,
                child: const ProductBenefitsSection(),
              ),

              FadeSlideTransition(index: 4, child: const QuantitySelector()),

              FadeSlideTransition(
                index: 5,
                child: const RelatedProductsSection(),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
