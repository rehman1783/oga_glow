import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/category/controllers/category_controller.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';

class HomeHotDeals extends GetView<HomeController> {
  const HomeHotDeals({super.key});

  @override
  Widget build(BuildContext context) {
    // Fix overflow: don't use `mainAxisAlignment: spaceBetween` inside a fixed-height card.
    final cs = Theme.of(context).colorScheme;

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
                    color: AppColors.goldDark,
                    size: 22.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Hot Deals',
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: 16.sp,
                      color: cs.onSurface,
                      // color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  final categoryController = Get.find<CategoryController>();
                  final mainNavController =
                      Get.find<MainNavigationController>();

                  categoryController.openCategory("All");
                  mainNavController.changeIndex(1);
                },
                child: Text(
                  'See All',
                  style: AppTextStyles.caption.copyWith(
                    // fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
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
              final colors = AppColors.of(context);
              return Container(
                width: 310.w,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: colors.gold.withValues(alpha: 0.3),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.gold,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      deal['discount']!,
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.white,
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
                                      color: colors.cream,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: colors.gold.withValues(
                                          alpha: 0.4,
                                        ),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 10.sp,
                                          color: colors.gold,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          deal['timeLeft']!,
                                          style: AppTextStyles.caption.copyWith(
                                            color: colors.gold,
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
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
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
                                  color: colors.textSecondary,
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
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: Container(
                                margin: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: colors.cream,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Image.asset(deal['image']!),
                                ),
                              ),
                            ),
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
                                      color: AppColors.primary.withValues(alpha: 0.4),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: AppColors.white,
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
