import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../home/widgets/product_card.dart';
import '../controllers/product_controller.dart';

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (c) {
        final related = c.relatedProducts;

        if (related.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Related Products',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.of(context).textPrimary,
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 320.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: related.length,
                  separatorBuilder: (_, __) => SizedBox(width: 0.w),
                  itemBuilder: (context, index) {
                    final product = related[index];
                    return ProductCard(
                      name: product['name']?.toString() ?? '',
                      price: product['price']?.toString() ?? '0',
                      image: product['image']?.toString() ?? '',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
