import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/wishlist/controllers/wishlist_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../cart/widgets/add_to_cart_bottom_sheet.dart';

class WishlistItemCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int index;

  const WishlistItemCard({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final WishlistController controller = Get.find<WishlistController>(
      tag: WishlistController.tag,
    );

    final String id = product['id']?.toString() ?? '';
    final String name = product['name']?.toString() ?? 'Product';
    final String category = product['category']?.toString() ?? 'General';
    final String price = product['price']?.toString() ?? '0';
    final String imageUrl = product['image']?.toString() ?? '';
    final String description = product['description']?.toString() ?? '';

    final Map<String, dynamic> productData = {
      'id': id,
      'name': name,
      'price': price,
      'image': imageUrl,
      'category': category,
      'description': description,
      ...product,
    };

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
          BounceTap(
            scaleBound: 0.94,
            onTap: () {
              Get.toNamed(
                AppRoutes.products_details,
                arguments: id.isNotEmpty ? id : productData,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                width: 84.r,
                height: 84.r,
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
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
                      onTap: () => controller.removeFromWishlist(productData),
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: AppColors.pureRed.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: AppColors.pureRed,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs. $price',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                      ),
                    ),

                    BounceTap(
                      scaleBound: 0.90,
                      onTap: () => AddToCartBottomSheet.show(context, productData),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryLight],
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.25),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_shopping_cart_rounded,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Add to Bag',
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
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
    );
  }
}
