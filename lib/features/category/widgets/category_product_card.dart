import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:oga_glow/app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../cart/widgets/add_to_cart_bottom_sheet.dart';

class CategoryProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const CategoryProductCard({super.key, required this.product});

  Map<String, dynamic> get _productData => {
    'name': product['name'],
    'category': product['category'],
    'price': product['price'],
    'image': product['image'],
  };

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: () => Get.toNamed(AppRoutes.products_details, arguments: product),
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
            /// Product Image
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: Image.asset(
                      product['image'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: Builder(
                      builder: (context) {
                        final wishlistController = Get.find<WishlistController>(
                          tag: WishlistController.tag,
                        );

                        return Obx(() {
                          final inWishlist = wishlistController.isInWishlist(
                            _productData,
                          );

                          return InkWell(
                            borderRadius: BorderRadius.circular(20.r),
                            onTap: () {
                              wishlistController.toggleWishlistItem(
                                _productData,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.of(context).cardBackground,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                inWishlist
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                                color: inWishlist
                                    ? AppColors.error
                                    : AppColors.of(context).textPrimary,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// Product Details
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs ${product['price']}',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BounceTap(
                          onTap: () => AddToCartBottomSheet.show(
                            context,
                            _productData,
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
