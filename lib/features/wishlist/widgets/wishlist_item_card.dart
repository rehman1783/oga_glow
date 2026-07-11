import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/wishlist/controllers/wishlist_controller.dart';

import '../../../core/theme/app_colors.dart';

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
    final controller = Get.find<WishlistController>();

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              product['image'],
              width: 90.w,
              height: 90.h,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['name'], maxLines: 2),

                SizedBox(height: 5.h),

                Text(product['category']),

                SizedBox(height: 5.h),

                Text("Rs. ${product['price']}"),
              ],
            ),
          ),

          Column(
            children: [
              Card(
                child: ElevatedButton(
                  onPressed: () => controller.removeItem(index),
                  child: const Text("Remove Item"),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  controller.addToCart(product);
                },
                child: const Text("Add To Cart"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
