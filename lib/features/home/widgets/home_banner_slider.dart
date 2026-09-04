import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';

class HomeBannerSlider extends GetView<HomeController> {
  const HomeBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final banners = controller.banners;

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            final promoTitles = [
              "Pure Ayurvedic Alchemy",
              "Hydrating Botanical Elixirs",
              "100% Organic Glow Routine"
            ];
            final promoSubtitles = [
              "Harness the power of ancient herbal extracts",
              "Deep nourishment for radiant, youthful skin",
              "Zero harmful chemicals • Cruelty-free"
            ];

            final title = index < promoTitles.length ? promoTitles[index] : "Natural Radiance";
            final subtitle = index < promoSubtitles.length ? promoSubtitles[index] : "Botanical Care";

            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: colors.border.withValues(alpha: 0.6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.07),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      banners[index],
                      fit: BoxFit.cover,
                    ),
                    // Refined Gradient Overlay
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.05),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.75),
                          ],
                          stops: const [0.0, 0.45, 1.0],
                        ),
                      ),
                    ),
                    // Promotional Editorial Text Overlay
                    Positioned(
                      left: 16.w,
                      right: 16.w,
                      bottom: 16.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.goldLight,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'FEATURED RITUAL',
                              style: TextStyle(
                                color: const Color(0xFF322300),
                                fontSize: 8.5.sp,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.88),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 195.h,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            autoPlayCurve: Curves.easeOutCubic,
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            onPageChanged: (index, reason) {
              controller.updateBanner(index);
            },
          ),
        ),

        SizedBox(height: 12.h),

        Obx(
          () => AnimatedSmoothIndicator(
            activeIndex: controller.currentBanner.value,
            count: controller.banners.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: AppColors.of(context).border,
              dotHeight: 6.h,
              dotWidth: 6.w,
              expansionFactor: 3.5,
              spacing: 5.w,
            ),
          ),
        ),
      ],
    );
  }
}