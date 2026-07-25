import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/routes/app_routes.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/bindings/cart_binding.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/product_controller.dart';
import '../../../core/widgets/bounce_tap.dart';

class ProductActionButtons extends GetView<ProductController> {
  const ProductActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<CartController>(tag: CartController.tag)) {
      CartBinding().dependencies();
    }

    return Obx(() {
      final product = controller.productModel.value;
      if (product == null) return const SizedBox.shrink();

      final legacyMap = {
        'id': product.id,
        'name': product.name,
        'price': product.finalPrice.toStringAsFixed(0),
        'originalPrice': product.price.toStringAsFixed(0),
        'image': product.mainImageUrl,
        'category': product.categoryDisplayName,
        'productModel': product,
      };

      final isOutOfStock = product.countInStock <= 0;

      return Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: BounceTap(
                  onTap: isOutOfStock
                      ? () {}
                      : () {
                          final cartController = Get.find<CartController>(
                            tag: CartController.tag,
                          );
                          cartController.addToCart(
                            legacyMap,
                            quantity: controller.quantity.value,
                          );
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: isOutOfStock
                          ? null
                          : const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryLight],
                            ),
                      color: isOutOfStock ? Colors.grey.shade400 : null,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: isOutOfStock
                          ? []
                          : [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isOutOfStock ? 'Out of Stock' : 'Add To Cart',
                      style: AppTextStyles.button.copyWith(fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: SizedBox(
                height: 50.h,
                child: BounceTap(
                  onTap: isOutOfStock
                      ? () {}
                      : () {
                          final cartController = Get.find<CartController>(
                            tag: CartController.tag,
                          );
                          cartController.addToCart(
                            legacyMap,
                            quantity: controller.quantity.value,
                          );
                          Get.toNamed(AppRoutes.checkout);
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isOutOfStock
                          ? Colors.grey.shade200
                          : AppColors.of(context).cardBackground,
                      border: Border.all(
                        color: isOutOfStock ? Colors.grey : AppColors.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Buy Now',
                      style: AppTextStyles.button.copyWith(
                        color: isOutOfStock ? Colors.grey : AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
