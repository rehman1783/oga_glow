import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../wishlist/bindings/wishlist_binding.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../cart/widgets/add_to_cart_bottom_sheet.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

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

    return BounceTap(
      onTap: () {
        Get.toNamed(AppRoutes.products_details, arguments: product.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        width: 165.w,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Product Image + Discount Badge + Wishlist Icon
            Expanded(
              flex: 6,
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
                                highlightColor: AppColors.primary.withValues(alpha: 0.1),
                                child: Container(color: AppColors.of(context).cardBackground),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.of(context).cardBackground,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            )
                          : Container(
                              color: AppColors.of(context).cardBackground,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.textSecondary,
                              ),
                            ),
                    ),
                  ),

                  /// Discount Savings Badge
                  if (product.hasDiscount)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
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
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),

                  /// Wishlist Icon
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Obx(() {
                      final inWishlist = wishlistController.isInWishlist(
                        _legacyProductMap,
                      );

                      return InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () {
                          wishlistController.toggleWishlistItem(_legacyProductMap);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.of(context).cardBackground.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            inWishlist ? Icons.favorite : Icons.favorite_border,
                            size: 18,
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

            /// Product Details + Quick Add to Cart
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),

                    SizedBox(height: 2.h),

                    Text(
                      product.categoryDisplayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),

                    const Spacer(),

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
                                Text(
                                  'Rs ${product.price.toStringAsFixed(0)}',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              Text(
                                'Rs ${product.finalPrice.toStringAsFixed(0)}',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        BounceTap(
                          onTap: () => AddToCartBottomSheet.show(
                            context,
                            _legacyProductMap,
                          ),
                          scaleBound: 0.85,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 16,
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
