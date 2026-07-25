import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/product_controller.dart';

class ProductImageSection extends GetView<ProductController> {
  const ProductImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final images = controller.productImages;
      if (images.isEmpty) {
        return Container(
          height: 300.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.of(context).cardBackground,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
          ),
        );
      }

      return Column(
        children: [
          SizedBox(height: 16.h),
          SizedBox(
            height: 320.h,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: images.length,
              onPageChanged: controller.changeImage,
              itemBuilder: (context, index) {
                final imageUrl = images[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: AppColors.of(context).cardBackground,
                        highlightColor: AppColors.primary.withValues(alpha: 0.1),
                        child: Container(color: AppColors.of(context).cardBackground),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.of(context).cardBackground,
                        child: Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (images.length > 1) ...[
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                final isSelected = controller.currentImageIndex.value == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: isSelected ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                );
              }),
            ),
          ],
        ],
      );
    });
  }
}
