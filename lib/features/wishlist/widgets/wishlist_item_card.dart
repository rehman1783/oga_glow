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
    final WishlistController controller = Get.find<WishlistController>(
      tag: WishlistController.tag,
    );

    final String id = product['id']?.toString() ?? '';
    final String name = product['name']?.toString() ?? '';
    final String category = product['category']?.toString() ?? '';
    final String price = product['price']?.toString() ?? '';
    final String imageUrl = product['image']?.toString() ?? '';
    final String description =
        product['description']?.toString() ?? '';

    final Map<String, dynamic> productData = {
      'id': id,
      'name': name,
      'price': price,
      'image': imageUrl,
      'category': category,
      'description': description,
      ...product,
    };

    return BounceTap(
      onTap: () {
        Get.toNamed(AppRoutes.products_details, arguments: id.isNotEmpty ? id : productData);
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.of(context).cardBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.of(context).border),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: SizedBox(
                width: 80.w,
                height: 80.h,
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.of(context).cardBackground,
                          highlightColor: AppColors.primary.withValues(alpha: 0.1),
                          child: Container(color: AppColors.of(context).cardBackground),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.textSecondary,
                        ),
                      )
                    : Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.textSecondary,
                      ),
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
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).cardBackground,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.of(context).border,
                      ),
                    ),
                    child: Text(
                      category,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.of(context).earth,
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

            SizedBox(width: 8.w),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BounceTap(
                  onTap: () => controller.removeItem(index),
                  scaleBound: 0.9,
                  child: Container(
                    width: 38.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).cardBackground,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.of(context).border,
                      ),
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.of(context).earth,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: 100.w,
                  height: 36.h,
                  child: BounceTap(
                    onTap: () => AddToCartBottomSheet.show(context, productData),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Add to Cart',
                        style: AppTextStyles.button.copyWith(fontSize: 12.sp),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
