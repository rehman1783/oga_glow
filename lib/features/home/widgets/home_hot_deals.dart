import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import 'package:oga_glow/app/routes/app_routes.dart';

class HomeHotDeals extends GetView<HomeController> {
  const HomeHotDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    color: AppColors.gold,
                    size: 22.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Hot Deals',
                    style: AppTextStyles.heading1.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.allProducts,
                    arguments: {'category': 'All'},
                  );
                },
                child: Text(
                  'See All',
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 175.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: controller.hotDeals.length,
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final deal = controller.hotDeals[index];
              return Container(
                width: 310.w,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.panel,
                  borderRadius: AppColors.radius,
                  border: Border.all(
                    color: AppColors.gold.withOpacity(0.25),
                    width: 1.2,
                  ),
                  boxShadow: AppColors.shadow2,
                ),
                child: Row(
                  children: [
                    // Text and Price section
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Timer / discount badge row
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.gold,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      deal['discount']!,
                                      style: AppTextStyles.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.cream,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AppColors.gold.withOpacity(0.3),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 10.sp,
                                          color: AppColors.gold,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          deal['timeLeft']!,
                                          style: AppTextStyles.caption.copyWith(
                                            color: AppColors.gold,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                deal['name']!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.heading2.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.text,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          // Price row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rs. ${deal['price']}',
                                style: AppTextStyles.heading2.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.sp,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Rs. ${deal['originalPrice']}',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.muted,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Image and buy button section
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Soft background behind image
                            Positioned.fill(
                              child: Container(
                                margin: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: AppColors.cream,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            // Product Image
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Image.asset(deal['image']!),
                                ),
                              ),
                            ),
                            // Premium Quick Shop Add Button
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 28.w,
                                width: 28.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.4),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
