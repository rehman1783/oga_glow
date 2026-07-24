import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/routes/app_routes.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/product_controller.dart';
import '../../../core/widgets/bounce_tap.dart';

class ProductActionButtons extends GetView<ProductController> {
  const ProductActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16.h),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: BounceTap(
                onTap: () {
                  final cartController = Get.find<CartController>(
                    tag: CartController.tag,
                  );
                  cartController.addToCart(
                    {...controller.product},
                    quantity: controller.quantity.value,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Add To Cart',
                    style: AppTextStyles.button.copyWith(fontSize: 14.sp),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: SizedBox(
              height: 50,
              child: BounceTap(
                onTap: () {
                  final cartController = Get.find<CartController>(
                    tag: CartController.tag,
                  );
                  cartController.addToCart(
                    {...controller.product},
                    quantity: controller.quantity.value,
                  );
                  Get.toNamed(AppRoutes.checkout);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.of(context).cardBackground,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Buy Now',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.primary,
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
  }
}
