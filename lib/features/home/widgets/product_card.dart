import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> get _productData => {
    'name': name,
    'price': price,
    'image': image,
    'category': 'General',
  };

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>(
      tag: WishlistController.tag,
    );

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.products_details, arguments: _productData);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        width: 160.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryLight,
              blurRadius: 8.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image + Wishlist Icon
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: Image.asset(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 10.w,
                    right: 10.w,
                    child: Obx(() {
                      final inWishlist = wishlistController.isInWishlist(
                        _productData,
                      );

                      return InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () {
                          wishlistController.toggleWishlistItem(_productData);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            inWishlist ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: inWishlist
                                ? Colors.red
                                : AppColors.textPrimary,
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
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Text(
                      'Rs ${price}',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
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
