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
import '../../drawer/widgets/app_drawer.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: AppBar(

        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(Icons.more_vert_rounded, color: colors.textPrimary),
        ),
        title: Text(
          'Product Catalog',
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final crossAxisCount = screenWidth >= 1100 ? 4 : (screenWidth >= 650 ? 3 : 2);
            final childAspectRatio = screenWidth >= 650 ? 0.68 : 0.60;

            return Column(
              children: [
                FadeSlideTransition(
                  index: 0,
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      SizedBox(
                        height: 44.h,
                        child: CategoryChipRow(controller: controller),
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors.cardBackground,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: colors.border),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: controller.searchController,
                            onChanged: controller.onSearchChanged,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 13.5.sp,
                            ),
                            decoration: InputDecoration(
                              hintText: "Search skincare, serums, creams...",
                              hintStyle: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 13.sp,
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: AppColors.primary,
                                size: 20.sp,
                              ),
                              suffixIcon: Obx(() {
                                if (controller.isSearchActive) {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: colors.textSecondary,
                                      size: 18.sp,
                                    ),
                                    onPressed: () {
                                      controller.searchController.clear();
                                      controller.onSearchChanged('');
                                    },
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                              filled: false,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Obx(() {
                          if (controller.searchSuggestions.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Container(
                            margin: EdgeInsets.only(top: 8.h),
                            decoration: BoxDecoration(
                              color: colors.cardBackground,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: colors.border),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(alpha: 0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.searchSuggestions.length,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                color: colors.border.withValues(alpha: 0.5),
                              ),
                              itemBuilder: (context, index) {
                                final product = controller.searchSuggestions[index];
                                return ListTile(
                                  dense: true,
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: SizedBox(
                                      width: 40.r,
                                      height: 40.r,
                                      child: product.mainImageUrl.isNotEmpty
                                          ? CachedNetworkImage(
                                              imageUrl: product.mainImageUrl,
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) =>
                                                  const Icon(Icons.spa_rounded),
                                            )
                                          : const Icon(Icons.spa_rounded),
                                    ),
                                  ),
                                  title: Text(
                                    product.name,
                                    style: AppTextStyles.body.copyWith(
                                      color: colors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Rs. ${product.finalPrice.toStringAsFixed(0)}',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13.sp,
                                    color: colors.textSecondary,
                                  ),
                                  onTap: () {
                                    controller.selectSuggestion(product);
                                  },
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: RefreshIndicator(
                      color: AppColors.primary,
                      backgroundColor: colors.cardBackground,
                      onRefresh: () async {
                        await controller.fetchCategoryProducts(forceRefresh: true);
                      },
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return GridView.builder(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            padding: EdgeInsets.only(bottom: 20.h),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 12.w,
                              mainAxisSpacing: 12.h,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: colors.panelSecondary,
                                highlightColor: colors.cardBackground,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors.cardBackground,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        if (controller.hasError.value) {
                          return CustomEmptyState(
                            icon: Icons.error_outline_rounded,
                            title: 'Failed to load products',
                            description: controller.errorMessage.value,
                            buttonText: 'Try Again',
                            onButtonPressed: () => controller.fetchProducts(forceRefresh: true),
                          );
                        }

                        final products = controller.filteredProducts;

                        if (products.isEmpty) {
                          return CustomEmptyState(
                            icon: Icons.search_off_rounded,
                            title: 'No Products Found',
                            description:
                                'Try searching for different keywords or browse another category.',
                            buttonText: 'Reset Filters',
                            onButtonPressed: () => controller.resetFilter(),
                          );
                        }

                        return GridView.builder(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          padding: EdgeInsets.only(bottom: 24.h),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return FadeSlideTransition(
                              index: index % 6,
                              child: CategoryProductCard(product: products[index]),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
