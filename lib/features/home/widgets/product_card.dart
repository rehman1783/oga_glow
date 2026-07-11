import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        Get.toNamed(
          AppRoutes.products_details,
          arguments: _productData,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        width: 160.w,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image + Wishlist Icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Image.asset(
                    image,
                    height: 120.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  right: 10.w,
                  top: 10.h,
                  child: Obx(() {
                    final inWishlist = wishlistController
                        .isInWishlist(_productData);

                    return InkWell(
                      borderRadius:
                          BorderRadius.circular(20.r),
                      onTap: () {
                        wishlistController
                            .addToWishlist(
                          _productData,
                        );
                      },
                      child: Icon(
                        inWishlist
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 22.w,
                        color: inWishlist
                            ? Colors.red
                            : Colors.white,
                      ),
                    );
                  }),
                ),
              ],
            ),

            /// Product Details
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style:
                        AppTextStyles.body.copyWith(
                      fontWeight:
                          FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    'Rs. $price',
                    style:
                        AppTextStyles.body.copyWith(
                      color:
                          AppColors.primary,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 4),
                      Text('4.8'),
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