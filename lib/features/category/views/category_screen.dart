import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Categories'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 45,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];

                    return CategoryChip(
                      title: category,
                      isSelected: controller.selectedCategory.value == category,
                      onTap: () {
                        controller.changeCategory(category);
                      },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Discover Our Products",
                style: AppTextStyles.heading2,
              ),
            ),

            // const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Find the perfect product for your beauty needs",
                style: AppTextStyles.caption,
              ),
            ),

            const SizedBox(height: 10),
            Obx(
              () => Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${controller.filteredProducts.length} Products Found",
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Obx(() {
                if (controller.filteredProducts.isEmpty) {
                  return const Center(child: Text("No Products Found"));
                }

                return GridView.builder(
                  itemCount: controller.filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
