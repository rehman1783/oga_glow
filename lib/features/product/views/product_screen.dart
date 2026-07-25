import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/product/widgets/product_image_slider.dart';

import '../controllers/product_controller.dart';
import '../widgets/product_action_buttons.dart';
import '../widgets/product_info_section.dart';
import '../widgets/related_products_section.dart';
import '../../../core/widgets/fade_slide_transition.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final targetId = args is String
        ? args
        : (args is Map ? args['id']?.toString() : null);

    if (targetId != null &&
        targetId.isNotEmpty &&
        targetId != controller.productId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadProductById(targetId);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBar: Obx(() {
        if (controller.isLoading.value ||
            controller.hasError.value ||
            controller.productModel.value == null) {
          return const SizedBox.shrink();
        }
        return const ProductActionButtons();
      }),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (controller.hasError.value) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 56.sp,
                      color: AppColors.error,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      controller.errorMessage.value.isNotEmpty
                          ? controller.errorMessage.value
                          : 'Unable to load product details.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.of(context).textPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    if (controller.productId != null)
                      ElevatedButton.icon(
                        onPressed: () =>
                            controller.fetchProductDetails(controller.productId!),
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Try Again'),
                      ),
                  ],
                ),
              ),
            );
          }

          final product = controller.productModel.value;
          if (product == null) {
            return Center(
              child: Text(
                'Product not found.',
                style: AppTextStyles.body
                    .copyWith(color: AppColors.of(context).textSecondary),
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                FadeSlideTransition(
                    index: 0, child: const ProductImageSection()),

                FadeSlideTransition(
                  index: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          ProductInfoSection(product: product),
                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                  ),
                ),

                FadeSlideTransition(
                  index: 2,
                  child: const RelatedProductsSection(),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}
