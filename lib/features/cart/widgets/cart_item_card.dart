import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const CartItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
          IconButton.filledTonal(
            onPressed: () {},
            tooltip: 'Remove from cart',
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
        ],
      ),
    );
  }
}
