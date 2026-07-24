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
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: controller.banners.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: AssetImage(
                    controller.banners[index],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 180.h,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              controller.updateBanner(index);
            },
          ),
        ),

        SizedBox(height: 15.h),

        Obx(
          () => AnimatedSmoothIndicator(
            activeIndex: controller.currentBanner.value,
            count: controller.banners.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: AppColors.of(context).border,
              dotHeight: 8.h,
              dotWidth: 8.w,
            ),
          ),
        ),
      ],
    );
  }
}