import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CategoryProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const CategoryProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.r),
              ),
              child: Image.asset(
                product['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
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
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Text(
                    'Rs ${product['price']}',
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
    );
  }
}