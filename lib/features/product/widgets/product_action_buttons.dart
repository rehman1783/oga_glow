import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../cart/bindings/cart_binding.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/widgets/add_to_cart_bottom_sheet.dart';
import '../controllers/product_controller.dart';

class ProductActionButtons extends GetView<ProductController> {
  const ProductActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<CartController>(tag: CartController.tag)) {
      CartBinding().dependencies();
    }

    final colors = AppColors.of(context);

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

      return Container(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          border: Border(top: BorderSide(color: colors.border)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Add to Bag Button
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: BounceTap(
                  scaleBound: 0.94,
                  onTap: isOutOfStock
                      ? () {}
                      : () => AddToCartBottomSheet.show(
                            context,
                            legacyMap,
                          ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.panelSecondary,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isOutOfStock ? colors.border : AppColors.primary.withValues(alpha: 0.4),
                        width: 1.2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 18.sp,
                          color: isOutOfStock ? colors.textSecondary : AppColors.primary,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          isOutOfStock ? 'Out of Stock' : 'Add to Bag',
                          style: AppTextStyles.button.copyWith(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w700,
                            color: isOutOfStock ? colors.textSecondary : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Instant Buy Now Button
            Expanded(
              child: SizedBox(
                height: 50.h,
                child: BounceTap(
                  scaleBound: 0.94,
                  onTap: isOutOfStock
                      ? () {}
                      : () {
                          final cart = Get.find<CartController>(tag: CartController.tag);
                          cart.addToCart(legacyMap, quantity: 1, showSnackbar: false);
                          Get.toNamed(AppRoutes.checkout);
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: isOutOfStock
                          ? null
                          : const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryLight],
                            ),
                      color: isOutOfStock ? colors.panelSecondary : null,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: isOutOfStock
                          ? []
                          : [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.28),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bolt_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Buy Now',
                          style: AppTextStyles.button.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: isOutOfStock ? colors.textSecondary : Colors.white,
                          ),
                        ),
                      ],
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
