import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/product_controller.dart';

class ProductImageSection extends GetView<ProductController> {
  const ProductImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (c) {
        return Column(
          children: [
            SizedBox(
              height: 320.h,
              child: PageView.builder(
                controller: c.pageController,
                itemCount: c.productImages.length,
                onPageChanged: c.changeImage,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(16.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        c.productImages[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 12.h),

            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(c.productImages.length, (index) {
                  final isSelected = c.currentImageIndex.value == index;

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
            ),
          ],
        );
      },
    );
  }
}
