import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../controllers/cart_controller.dart';
import 'quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int index;

  const CartItemCard({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>(tag: CartController.tag);

    final String name = product['name']?.toString() ?? '';
    final String category = product['category']?.toString() ?? '';
    final String price = product['price']?.toString() ?? '0';
    final String imagePath = product['image']?.toString() ?? '';
    final int quantity =
        int.tryParse(product['quantity']?.toString() ?? '1') ?? 1;
    final String description =
        product['description']?.toString() ?? 'No description available';

    final double unitPrice = double.tryParse(
          price.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0.0;
    final double itemTotal = unitPrice * quantity;

    final String formattedTotal = (itemTotal % 1 == 0)
        ? itemTotal.toInt().toString()
        : itemTotal.toStringAsFixed(2);

    final Map<String, dynamic> productData = {
      'name': name,
      'price': price,
      'image': imagePath,
      'category': category,
      'description': description,
    };

    return BounceTap(
      onTap: () {
        Get.toNamed(AppRoutes.products_details, arguments: productData);
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.of(context).cardBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.of(context).border),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: imagePath.isNotEmpty
                  ? Image.asset(
                      imagePath,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 80.w,
                        height: 80.h,
                        color: AppColors.of(context).panelSecondary,
                        child: const Icon(Icons.image_not_supported_outlined),
                      ),
                    )
                  : Container(
                      width: 80.w,
                      height: 80.h,
                      color: AppColors.of(context).panelSecondary,
                      child: const Icon(Icons.shopping_bag_outlined),
                    ),
            ),

            SizedBox(width: 12.w),

            /// Product Details + Quantity Controls
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading2.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.of(context).textPrimary,
                          ),
                        ),
                      ),
                      BounceTap(
                        onTap: () {
                          cartController.removeItem(index);
                        },
                        scaleBound: 0.9,
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.of(context).earth,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).cardBackground,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.of(context).border,
                      ),
                    ),
                    child: Text(
                      category,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.of(context).earth,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs. $formattedTotal',
                        style: AppTextStyles.heading2.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      QuantitySelector(
                        quantity: quantity,
                        minQuantity: 1,
                        height: 32,
                        iconSize: 16,
                        onIncrement: () => cartController.increaseQuantity(index),
                        onDecrement: () => cartController.decreaseQuantity(index),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
