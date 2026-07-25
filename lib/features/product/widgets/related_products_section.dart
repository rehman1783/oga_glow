import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../home/widgets/product_card.dart';
import '../controllers/product_controller.dart';

class RelatedProductsSection extends GetView<ProductController> {
  const RelatedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final related = controller.relatedProducts;

      if (related.isEmpty) return const SizedBox.shrink();

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Related Products',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 16.sp,
                color: AppColors.of(context).textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 260.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: related.length,
                separatorBuilder: (_, __) => SizedBox(width: 0.w),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: related[index],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
