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

    final colors = AppColors.of(context);
    final rating = product.averageRating > 0 ? product.averageRating : 4.8;

    return BounceTap(
      scaleBound: 0.96,
      onTap: () => Get.toNamed(
        AppRoutes.products_details,
        arguments: product.id,
        preventDuplicates: false,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: colors.border.withValues(alpha: 0.8),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.03),
              blurRadius: 16.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image + Discount Badge + Wishlist Button
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(19.r),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: product.mainImageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: product.mainImageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: colors.panelSecondary,
                                highlightColor: colors.cardBackground,
                                child: Container(
                                  color: colors.panelSecondary,
                                ),
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

                  // Subtle gradient shadow overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.15),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.08),
                          ],
                          stops: const [0.0, 0.3, 0.7, 1.0],
                        ),
                      ),
                    ),
                  ),

                  /// Discount Savings Badge (Proper Vivid Fire Red)
                  if (product.hasDiscount)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 3.5.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.redGradient,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${product.discountPercentage}% OFF',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 9.sp,
                            letterSpacing: 0.3,
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

                      return BounceTap(
                        scaleBound: 0.82,
                        onTap: () {
                          wishlistController.toggleWishlistItem(_legacyProductMap);
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: colors.cardBackground.withValues(alpha: 0.85),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.border.withValues(alpha: 0.6),
                              width: 0.8,
                            ),
                          ),
                          child: Icon(
                            inWishlist
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 15.sp,
                            color: inWishlist
                                ? AppColors.pureRed
                                : colors.textPrimary,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            /// Product Details & Price
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5.sp,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.categoryDisplayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.caption.copyWith(
                                color: colors.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 10.sp,
                                  color: Colors.amber.shade700,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 9.sp,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
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
                                    color: colors.textSecondary,
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
                                style: AppTextStyles.heading2.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13.5.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4.w),
                      BounceTap(
                        scaleBound: 0.82,
                        onTap: () => AddToCartBottomSheet.show(
                          context,
                          _legacyProductMap,
                        ),
                        child: Container(
                          width: 30.r,
                          height: 30.r,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryLight],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            size: 18.sp,
                            color: Colors.white,
                          ),
                        ),
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
