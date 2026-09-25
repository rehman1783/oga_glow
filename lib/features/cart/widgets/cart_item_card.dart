import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_network_image.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../controllers/cart_controller.dart';

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
    final colors = AppColors.of(context);
    final cartController = Get.find<CartController>(tag: CartController.tag);

    final String id = product['id']?.toString() ?? '';
    final String name = product['name']?.toString() ?? 'Product';
    final String category = product['category']?.toString() ?? 'General';
    final String price = product['price']?.toString() ?? '0';
    final String origPrice = product['originalPrice']?.toString() ?? product['price']?.toString() ?? '0';
    final String imageUrl = product['image']?.toString() ?? '';
    final int quantity =
        int.tryParse(product['quantity']?.toString() ?? '1') ?? 1;

    final double unitPrice = double.tryParse(
          price.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0.0;
    final double originalUnitPrice = double.tryParse(
          origPrice.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        unitPrice;
    final double itemTotal = unitPrice * quantity;
    final double originalItemTotal = originalUnitPrice * quantity;
    final bool hasDiscount = originalItemTotal > itemTotal;

    final String formattedTotal = (itemTotal % 1 == 0)
        ? itemTotal.toInt().toString()
        : itemTotal.toStringAsFixed(2);
    final String formattedOrigTotal = (originalItemTotal % 1 == 0)
        ? originalItemTotal.toInt().toString()
        : originalItemTotal.toStringAsFixed(0);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.8),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Product Image with Tap to Details
          BounceTap(
            scaleBound: 0.94,
            onTap: () {
              Get.toNamed(
                AppRoutes.products_details,
                arguments: id.isNotEmpty ? id : product,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                width: 84.r,
                height: 84.r,
                child: imageUrl.isNotEmpty
                    ? CustomNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: colors.panelSecondary,
                          highlightColor: colors.cardBackground,
                          child: Container(color: colors.panelSecondary),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: colors.panelSecondary,
                          child: Icon(
                            Icons.spa_rounded,
                            color: AppColors.primary.withValues(alpha: 0.4),
                            size: 28.sp,
                          ),
                        ),
                      )
                    : Container(
                        color: colors.panelSecondary,
                        child: Icon(
                          Icons.spa_rounded,
                          color: AppColors.primary.withValues(alpha: 0.4),
                          size: 28.sp,
                        ),
                      ),
              ),
            ),
          ),

          SizedBox(width: 14.w),

          /// Product Details + Stepper + Delete
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading2.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            category,
                            style: AppTextStyles.caption.copyWith(
                              color: colors.textSecondary,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BounceTap(
                      scaleBound: 0.85,
                      onTap: () => cartController.removeItem(index),
                      child: Container(
                        padding: EdgeInsets.all(6.5.r),
                        decoration: BoxDecoration(
                          color: AppColors.pureRed.withValues(alpha: 0.10),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.pureRed.withValues(alpha: 0.28),
                            width: 1.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.delete_rounded,
                          color: AppColors.pureRed,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hasDiscount) ...[
                          Row(
                            children: [
                              Text(
                                'Rs. $formattedOrigTotal',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 10.5.sp,
                                  decoration: TextDecoration.lineThrough,
                                  color: colors.textSecondary.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 1.5.h,
                                ),
                                decoration: BoxDecoration(
                                  gradient: AppColors.redGradient,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  '${(((originalItemTotal - itemTotal) / originalItemTotal) * 100).round()}% OFF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 8.5.sp,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                        ],
                        Text(
                          'Rs. $formattedTotal',
                          style: AppTextStyles.heading2.copyWith(
                            color: hasDiscount ? AppColors.pureRed : AppColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),

                    // Modern Stepper
                    Container(
                      height: 34.h,
                      decoration: BoxDecoration(
                        color: colors.panelSecondary,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: colors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BounceTap(
                            scaleBound: 0.80,
                            onTap: () => cartController.decreaseQuantity(index),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Icon(
                                quantity > 1 ? Icons.remove_rounded : Icons.delete_rounded,
                                size: 16.sp,
                                color: quantity > 1 ? colors.textPrimary : AppColors.pureRed,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Text(
                              '$quantity',
                              style: AppTextStyles.body.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                          BounceTap(
                            scaleBound: 0.80,
                            onTap: () => cartController.increaseQuantity(index),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Icon(
                                Icons.add_rounded,
                                size: 16.sp,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
