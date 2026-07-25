import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/data/models/product_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../wishlist/bindings/wishlist_binding.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../cart/widgets/add_to_cart_bottom_sheet.dart';

class CategoryProductCard extends StatelessWidget {
  final ProductModel product;

  const CategoryProductCard({super.key, required this.product});

  Map<String, dynamic> get _legacyProductMap => {
    'id': product.id,
    'name': product.name,
    'price': product.finalPrice.toStringAsFixed(0),
    'originalPrice': product.price.toStringAsFixed(0),
    'image': product.mainImageUrl,
    'category': product.categoryDisplayName,
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

    final rating = product.averageRating > 0 ? product.averageRating : 4.5;
    final reviews = product.totalReviews > 0 ? product.totalReviews : 12;

    return BounceTap(
      onTap: () => Get.toNamed(
        AppRoutes.products_details,
        arguments: product.id,
        preventDuplicates: false,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.of(context).cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8.r,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.03),
              blurRadius: 14.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image + Discount Badge + Wishlist Button
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: product.mainImageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: product.mainImageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: AppColors.of(context).cardBackground,
                                highlightColor: AppColors.primary.withValues(
                                  alpha: 0.1,
                                ),
                                child: Container(
                                  color: AppColors.of(context).cardBackground,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.of(context).cardBackground,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.of(context).textSecondary,
                                ),
                              ),
                            )
                          : Container(
                              color: AppColors.of(context).cardBackground,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.of(context).textSecondary,
                              ),
                            ),
                    ),
                  ),

                  /// Discount Savings Badge
                  if (product.hasDiscount)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          '${product.discountPercentage}% OFF',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 9.sp,
                          ),
                        ),
                      ),
                    ),

                  /// Wishlist Icon
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Obx(() {
                      final inWishlist = wishlistController.isInWishlist(
                        _legacyProductMap,
                      );

                      return InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () {
                          wishlistController.toggleWishlistItem(
                            _legacyProductMap,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: AppColors.of(
                              context,
                            ).cardBackground.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            inWishlist ? Icons.favorite : Icons.favorite_border,
                            size: 16.sp,
                            color: inWishlist
                                ? AppColors.error
                                : AppColors.of(context).textPrimary,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            /// Product Details
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            color: AppColors.of(context).textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.categoryDisplayName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.of(context).textSecondary,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 12.sp,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                    color: AppColors.of(context).textPrimary,
                                  ),
                                ),
                                Text(
                                  ' ($reviews)',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 9.sp,
                                    color: AppColors.of(context).textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (product.hasDiscount)
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Rs ${product.price.toStringAsFixed(0)}',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.of(
                                        context,
                                      ).textSecondary,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Rs ${product.finalPrice.toStringAsFixed(0)}',
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 4.w),
                        BounceTap(
                          onTap: () => AddToCartBottomSheet.show(
                            context,
                            _legacyProductMap,
                          ),
                          scaleBound: 0.85,
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 15.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
