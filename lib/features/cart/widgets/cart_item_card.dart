import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/cart_controller.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int index;

  const CartItemCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final String name = product['name']?.toString() ?? '';
    final String category = product['category']?.toString() ?? '';
    final String price = product['price']?.toString() ?? '';
    final String imagePath = product['image']?.toString() ?? '';
    final String description =
        product['description']?.toString() ?? 'No description available';

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
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Image.asset(
                imagePath,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading2.copyWith(fontSize: 14.sp),
                  ),

                  SizedBox(height: 6.h),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.border.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      category,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.accent,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),
                  Text(
                    'Rs. $price',
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10.w),

            BounceTap(
              onTap: () {
                final cart = Get.find<CartController>(tag: CartController.tag);
                cart.removeItem(index);
              },
              scaleBound: 0.9,
              child: Container(
                width: 38.w,
                height: 38.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.accent.withOpacity(0.15)),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
