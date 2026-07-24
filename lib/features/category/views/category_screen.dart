import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/category/widgets/category_product_card.dart';

import '../controllers/category_controller.dart';
import 'category_chip_row.dart';
import '../../../core/widgets/fade_slide_transition.dart';
import '../../drawer/widgets/app_drawer.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.syncFromRouteArguments();

    return Scaffold(
      // drawer: const AppDrawer(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu_book_sharp),
        ),
        title: Text(
          'Categories',
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18,
            color: AppColors.of(context).textPrimary,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            FadeSlideTransition(
              index: 0,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    child: CategoryChipRow(controller: controller),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                    style: TextStyle(color: AppColors.of(context).textPrimary),
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: AppColors.of(context).inputBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.searchSuggestions.isEmpty) {
                      return const SizedBox();
                    }

                    return Container(
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: AppColors.of(context).cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.searchSuggestions.length,
                        itemBuilder: (context, index) {
                          final product =
                              controller.searchSuggestions[index];

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(product["image"]),
                            ),
                            title: Text(
                              product["name"],
                              style: TextStyle(color: AppColors.of(context).textPrimary),
                            ),
                            subtitle: Text(
                              product["category"],
                              style: TextStyle(color: AppColors.of(context).textSecondary),
                            ),
                            onTap: () {
                              controller.selectSuggestion(product);
                            },
                          );
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 14),
                ],
              ),
            ),

            FadeSlideTransition(
              index: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Discover Our Products",
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 16,
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Find the perfect product for your beauty needs",
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.of(context).textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${controller.filteredProducts.length} Products Found",
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.filteredProducts.isEmpty) {
                  return const Center(child: Text("No Products Found"));
                }

                return GridView.builder(
                  itemCount: controller.filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.74,
                  ),
                  itemBuilder: (context, index) {
                    return FadeSlideTransition(
                      index: index + 2, // stagger the grid items
                      child: CategoryProductCard(
                        product: controller.filteredProducts[index],
                      ),
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
