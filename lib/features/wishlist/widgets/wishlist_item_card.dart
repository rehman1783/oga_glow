import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/wishlist/controllers/wishlist_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

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

    final String name = product['name']?.toString() ?? '';
    final String category = product['category']?.toString() ?? '';
    final String price = product['price']?.toString() ?? '';
    final String imagePath = product['image']?.toString() ?? '';

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              imagePath,
              width: 86.w,
              height: 86.h,
              fit: BoxFit.cover,
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading2,
                ),

                SizedBox(height: 6.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.chipUnselected,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(category, style: AppTextStyles.caption),
                ),

                SizedBox(height: 6.h),

                Text('Rs. $price', style: AppTextStyles.heading1),
              ],
            ),
          ),

          SizedBox(width: 10.w),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                onPressed: () => controller.removeItem(index),
                tooltip: 'Remove from wishlist',
                icon: const Icon(Icons.delete_outline),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.accent,
                  fixedSize: Size(42.w, 42.h),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 110.w,
                height: 38.h,
                child: ElevatedButton(
                  onPressed: () => controller.addToCartDynamic(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: AppTextStyles.button,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
