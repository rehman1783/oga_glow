import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/custom_empty_state.dart';
import 'package:oga_glow/features/category/widgets/category_product_card.dart';

import '../controllers/category_controller.dart';
import 'category_chip_row.dart';
import '../../../core/widgets/fade_slide_transition.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            fontSize: 18.sp,
            color: AppColors.of(context).textPrimary,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            FadeSlideTransition(
              index: 0,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 45.h,
                    child: CategoryChipRow(controller: controller),
                  ),
                  SizedBox(height: 14.h),
                  TextField(
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                    style: TextStyle(color: AppColors.of(context).textPrimary),
                    decoration: InputDecoration(
                      hintText: "Search products by name, category, details...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: AppColors.of(context).inputBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.searchSuggestions.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      margin: EdgeInsets.only(top: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.of(context).cardBackground,
                        borderRadius: BorderRadius.circular(12.r),
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
                          final product = controller.searchSuggestions[index];

                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: SizedBox(
                                width: 40.w,
                                height: 40.w,
                                child: product.mainImageUrl.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: product.mainImageUrl,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => const Icon(
                                          Icons.image_not_supported_outlined,
                                        ),
                                      )
                                    : const Icon(Icons.image_not_supported_outlined),
                              ),
                            ),
                            title: Text(
                              product.name,
                              style: TextStyle(color: AppColors.of(context).textPrimary),
                            ),
                            subtitle: Text(
                              product.categoryDisplayName,
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
                  SizedBox(height: 14.h),
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
                        fontSize: 16.sp,
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Find the perfect product for your beauty needs",
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.of(context).textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
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
                  SizedBox(height: 10.h),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.63,
                    ),
                    itemBuilder: (context, index) => Shimmer.fromColors(
                      baseColor: AppColors.of(context).cardBackground,
                      highlightColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.of(context).cardBackground,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                    ),
                  );
                }

                if (controller.hasError.value) {
                  return CustomEmptyState(
                    icon: Icons.wifi_off_rounded,
                    title: 'Connection Issue',
                    description: controller.errorMessage.value.isNotEmpty
                        ? controller.errorMessage.value
                        : 'Unable to connect to the store. Please check your network.',
                    buttonText: 'Try Again',
                    onButtonPressed: () => controller.fetchCategoryProducts(),
                  );
                }

                if (controller.filteredProducts.isEmpty) {
                  // Empty search state
                  if (controller.searchText.value.isNotEmpty) {
                    return CustomEmptyState(
                      icon: Icons.search_off_rounded,
                      title: 'No Products Found',
                      description:
                          'No products matched "${controller.searchText.value}". Try searching with different keywords.',
                      buttonText: 'Clear Search',
                      onButtonPressed: () {
                        controller.searchController.clear();
                        controller.onSearchChanged('');
                      },
                    );
                  }

                  // Empty category state
                  if (controller.selectedCategory.value != "All") {
                    return CustomEmptyState(
                      icon: Icons.category_outlined,
                      title: 'No Products Available',
                      description:
                          'Products for "${controller.selectedCategory.value}" will be available soon.',
                      buttonText: 'View All Products',
                      onButtonPressed: () => controller.changeCategory('All'),
                    );
                  }

                  // General empty product list
                  return CustomEmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'No Products Available',
                    description: 'There are currently no products in the catalog.',
                    buttonText: 'Refresh Catalog',
                    onButtonPressed: () => controller.fetchCategoryProducts(),
                  );
                }

                return GridView.builder(
                  itemCount: controller.filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.63,
                  ),
                  itemBuilder: (context, index) {
                    return FadeSlideTransition(
                      index: index + 2,
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
