import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/category/controllers/category_controller.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';
import 'package:oga_glow/features/cart/widgets/add_to_cart_bottom_sheet.dart';
import 'package:oga_glow/core/widgets/bounce_tap.dart';
import 'package:shimmer/shimmer.dart';

class HomeHotDeals extends GetView<HomeController> {
  const HomeHotDeals({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Obx(() {
      final hotDeals = controller.hotDeals;
      if (hotDeals.isEmpty && !controller.isLoading.value) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.local_fire_department_rounded,
                        color: Colors.amber.shade700,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Hot Deals',
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE11D48), Color(0xFFF43F5E)],
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'LIMITED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    if (Get.isRegistered<CategoryController>()) {
                      Get.find<CategoryController>().openCategory("All");
                    }
                    if (Get.isRegistered<MainNavigationController>()) {
                      Get.find<MainNavigationController>().changeIndex(1);
                    }
                  },
                  child: Text(
                    'See All',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 190.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: hotDeals.length,
              separatorBuilder: (context, index) => SizedBox(width: 14.w),
              itemBuilder: (context, index) {
                final deal = hotDeals[index];
                return BounceTap(
                  scaleBound: 0.97,
                  onTap: () => Get.toNamed(AppRoutes.products_details, arguments: deal.id),
                  child: Container(
                    width: 320.w,
                    padding: EdgeInsets.all(13.w),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(22.r),
                      border: Border.all(
                        color: colors.gold.withValues(alpha: 0.35),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.05),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                        BoxShadow(
                          color: colors.gold.withValues(alpha: 0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (deal.hasDiscount)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 3.5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFE11D48), Color(0xFFBE123C)],
                                        ),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Text(
                                        'SAVE ${deal.discountPercentage}%',
                                        style: AppTextStyles.caption.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 9.sp,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    deal.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.heading2.copyWith(
                                      fontSize: 14.sp,
                                      color: colors.textPrimary,
                                      fontWeight: FontWeight.w700,
                                      height: 1.25,
                                    ),
                                  ),
                                ],
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'Rs. ${deal.finalPrice.toStringAsFixed(0)}',
                                      style: AppTextStyles.heading2.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    if (deal.hasDiscount) ...[
                                      SizedBox(width: 6.w),
                                      Text(
                                        'Rs. ${deal.price.toStringAsFixed(0)}',
                                        style: AppTextStyles.caption.copyWith(
                                          color: colors.textSecondary,
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 10.w),
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: deal.mainImageUrl.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: deal.mainImageUrl,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: colors.panelSecondary,
                                              highlightColor: colors.cardBackground,
                                              child: Container(color: colors.panelSecondary),
                                            ),
                                            errorWidget: (context, url, error) =>
                                                Container(
                                              color: colors.panelSecondary,
                                              child: Icon(
                                                Icons.spa_rounded,
                                                color: AppColors.primary.withValues(alpha: 0.4),
                                                size: 32.sp,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: colors.panelSecondary,
                                            child: Icon(
                                              Icons.spa_rounded,
                                              color: AppColors.primary.withValues(alpha: 0.4),
                                              size: 32.sp,
                                            ),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 6.h,
                                  right: 6.w,
                                  child: BounceTap(
                                    scaleBound: 0.82,
                                    onTap: () {
                                      AddToCartBottomSheet.show(context, {
                                        'id': deal.id,
                                        'name': deal.name,
                                        'price': deal.finalPrice.toStringAsFixed(0),
                                        'originalPrice': deal.price.toStringAsFixed(0),
                                        'image': deal.mainImageUrl,
                                        'category': deal.categoryDisplayName,
                                        'productModel': deal,
                                      });
                                    },
                                    child: Container(
                                      width: 32.w,
                                      height: 32.w,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [AppColors.primary, AppColors.primaryLight],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary.withValues(alpha: 0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.add_shopping_cart_rounded,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
