import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/category/widgets/category_product_card.dart';

import '../../home/widgets/product_card.dart';
import '../controllers/category_controller.dart';
import '../widgets/category_chip.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category =
                        controller.categories[index];

                    return CategoryChip(
                      title: category,
                      isSelected:
                          controller.selectedCategory.value ==
                              category,
                      onTap: () {
                        controller.changeCategory(
                          category
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
  child: Obx(
    () => GridView.builder(
      itemCount: controller.filteredProducts.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return CategoryProductCard(
          product: controller.filteredProducts[index],
        );
      },
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}