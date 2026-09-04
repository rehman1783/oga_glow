import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../cart/widgets/add_to_cart_bottom_sheet.dart';
import '../../category/controllers/category_controller.dart';
import '../../main_navigation/controllers/main_navigation_controller.dart';
import '../controllers/home_controller.dart';

class HomeBannerSlider extends GetView<HomeController> {
  const HomeBannerSlider({super.key});

  void _navigateToCatalog() {
    if (Get.isRegistered<CategoryController>()) {
      Get.find<CategoryController>().openCategory("All");
    }
    if (Get.isRegistered<MainNavigationController>()) {
      Get.find<MainNavigationController>().changeIndex(1);
    }
  }

  Widget _buildShimmer(BuildContext context, AppThemeColors colors) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 140.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: colors.panelSecondary,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              Container(
                width: 60.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: colors.panelSecondary,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Shimmer.fromColors(
          baseColor: colors.panelSecondary,
          highlightColor: colors.cardBackground,
          child: Container(
            height: 188.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.circular(22.r),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmer(context, colors);
      }

      final hotDeals = controller.hotDeals;
      final displayDeals = hotDeals.isNotEmpty
          ? hotDeals
          : controller.allProducts.take(4).toList();

      if (displayDeals.isEmpty) {
        return const SizedBox.shrink();
      }

      final activeIndex = controller.currentBanner.value.clamp(
        0,
        displayDeals.isNotEmpty ? displayDeals.length - 1 : 0,
      );

      return Column(
        children: [
          /// Header: Flash Deals Title & Action
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
                        gradient: AppColors.goldGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.goldLight.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.bolt_rounded,
                        color: const Color(0xFF382A00),
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Flash Deals',
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 16.5.sp,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 7.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 2.5.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE53935), Color(0xFFC62828)],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE53935).withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer_outlined, size: 9.5.sp, color: Colors.white),
                          SizedBox(width: 3.w),
                          Text(
                            'ENDS TODAY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.5.sp,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                BounceTap(
                  onTap: _navigateToCatalog,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View All',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10.5.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          /// Deals Carousel Slider (Powered by Live API)
          CarouselSlider.builder(
            itemCount: displayDeals.length,
            itemBuilder: (context, index, realIndex) {
              final deal = displayDeals[index];

              return BounceTap(
                scaleBound: 0.97,
                onTap: () => Get.toNamed(
                  AppRoutes.products_details,
                  arguments: deal.id,
                ),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      color: AppColors.goldLight.withValues(alpha: 0.45),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.04),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: AppColors.goldLight.withValues(alpha: 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      /// Left Details Column
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
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: AppColors.redGradient,
                                      borderRadius: BorderRadius.circular(7.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.pureRed.withValues(alpha: 0.3),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'SAVE ${deal.discountPercentage}%',
                                      style: AppTextStyles.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 8.5.sp,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: AppColors.luxuryGradient,
                                      borderRadius: BorderRadius.circular(7.r),
                                    ),
                                    child: Text(
                                      'FEATURED OFFER',
                                      style: AppTextStyles.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 8.5.sp,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 7.h),
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
                                SizedBox(height: 3.h),
                                Text(
                                  deal.categoryDisplayName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.caption.copyWith(
                                    color: colors.textSecondary,
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            /// Price & Claim CTA
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
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
                                SizedBox(height: 6.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.luxuryGradient,
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(alpha: 0.25),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Shop Deal',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.5.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 11.sp,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10.w),

                      /// Right Product Image with Quick Add
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
                                    width: 32.r,
                                    height: 32.r,
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
            options: CarouselOptions(
              height: 196.h,
              autoPlay: displayDeals.length > 1,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 700),
              autoPlayCurve: Curves.easeOutCubic,
              viewportFraction: 0.92,
              enlargeCenterPage: true,
              enlargeFactor: 0.16,
              onPageChanged: (index, reason) {
                controller.updateBanner(index);
              },
            ),
          ),

          if (displayDeals.length > 1) ...[
            SizedBox(height: 10.h),
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: displayDeals.length,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.primary,
                dotColor: AppColors.of(context).border,
                dotHeight: 5.5.h,
                dotWidth: 6.w,
                expansionFactor: 3.5,
                spacing: 5.w,
              ),
            ),
          ],
        ],
      );
    });
  }
}