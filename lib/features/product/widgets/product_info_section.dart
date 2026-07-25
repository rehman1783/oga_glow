import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/features/wishlist/controllers/wishlist_controller.dart';
import 'package:oga_glow/features/wishlist/bindings/wishlist_binding.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductModel product;

  const ProductInfoSection({super.key, required this.product});

  Map<String, dynamic> get _legacyProductMap => {
    'id': product.id,
    'name': product.name,
    'price': product.finalPrice.toStringAsFixed(0),
    'originalPrice': product.price.toStringAsFixed(0),
    'image': product.mainImageUrl,
    'category': product.categoryDisplayName,
    'description': product.description,
    'productModel': product,
  };

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WishlistController>(tag: WishlistController.tag)) {
      WishlistBinding().dependencies();
    }

    final wishlistController = Get.find<WishlistController>(
      tag: WishlistController.tag,
    );

    final colors = AppColors.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Category Chip & Stock Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  product.categoryDisplayName,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// Stock Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: product.countInStock > 0
                      ? Colors.green.withValues(alpha: 0.1)
                      : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      product.countInStock > 0 ? Icons.check_circle : Icons.cancel,
                      size: 14.sp,
                      color: product.countInStock > 0 ? Colors.green : AppColors.error,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      product.countInStock > 0
                          ? 'In Stock (${product.countInStock})'
                          : 'Out of Stock',
                      style: AppTextStyles.caption.copyWith(
                        color: product.countInStock > 0 ? Colors.green : AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// Product Title & Wishlist Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: AppTextStyles.heading1.copyWith(
                    color: colors.textPrimary,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Obx(() {
                final inWishlist = wishlistController.isInWishlist(_legacyProductMap);

                return InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () => wishlistController.toggleWishlistItem(_legacyProductMap),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Icon(
                      inWishlist ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: inWishlist ? AppColors.error : colors.textPrimary,
                    ),
                  ),
                );
              }),
            ],
          ),

          SizedBox(height: 8.h),

          /// Rating & Total Reviews
          Row(
            children: [
              Icon(Icons.star_rounded, size: 20.sp, color: Colors.amber),
              SizedBox(width: 4.w),
              Text(
                product.averageRating > 0
                    ? product.averageRating.toStringAsFixed(1)
                    : '4.8',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                '(${product.totalReviews > 0 ? product.totalReviews : 12} reviews)',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// Price & Discount Section
          Row(
            children: [
              Text(
                'Rs ${product.finalPrice.toStringAsFixed(0)}',
                style: AppTextStyles.heading1.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  fontSize: 22.sp,
                ),
              ),
              if (product.hasDiscount) ...[
                SizedBox(width: 10.w),
                Text(
                  'Rs ${product.price.toStringAsFixed(0)}',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${product.discountPercentage}% OFF',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: 12.h),

          /// Shipping Price & Tax
          Row(
            children: [
              Icon(Icons.local_shipping_outlined, size: 16.sp, color: AppColors.textSecondary),
              SizedBox(width: 4.w),
              Text(
                product.shippingPrice > 0
                    ? 'Shipping: Rs ${product.shippingPrice.toStringAsFixed(0)}'
                    : 'Free Shipping',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(width: 12.w),
              Icon(Icons.receipt_long_outlined, size: 16.sp, color: AppColors.textSecondary),
              SizedBox(width: 4.w),
              Text(
                product.taxRate > 0
                    ? 'Tax: ${(product.taxRate * 100).toStringAsFixed(0)}%'
                    : 'Tax Included',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          /// Description Section
          if (product.description.isNotEmpty) ...[
            Text(
              'Description',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 16.sp,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              product.description,
              style: AppTextStyles.body.copyWith(
                color: colors.textPrimary.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),
          ],

          /// Ingredients Section
          if (product.ingredients.isNotEmpty) ...[
            Text(
              'Ingredients',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 16.sp,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
              ),
              child: Text(
                product.ingredients,
                style: AppTextStyles.body.copyWith(
                  color: colors.textPrimary.withValues(alpha: 0.85),
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],

          /// Benefits Section
          if (product.benefits.isNotEmpty) ...[
            Text(
              'Benefits',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 16.sp,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
              ),
              child: Text(
                product.benefits,
                style: AppTextStyles.body.copyWith(
                  color: colors.textPrimary.withValues(alpha: 0.85),
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],

          /// How To Use Section
          if (product.howToUse.isNotEmpty) ...[
            Text(
              'How To Use',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 16.sp,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
              ),
              child: Text(
                product.howToUse,
                style: AppTextStyles.body.copyWith(
                  color: colors.textPrimary.withValues(alpha: 0.85),
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ],
      ),
    );
  }
}
