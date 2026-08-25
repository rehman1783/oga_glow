import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/category/controllers/category_controller.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import 'package:oga_glow/features/home/widgets/brand_features_section.dart';
import 'package:oga_glow/features/home/widgets/home_app_bar.dart';
import 'package:oga_glow/features/home/widgets/home_banner_slider.dart';
import 'package:oga_glow/features/home/widgets/home_categories.dart';
import 'package:oga_glow/features/home/widgets/home_hot_deals.dart';
import 'package:oga_glow/features/home/widgets/product_card.dart';
import 'package:oga_glow/features/home/widgets/section_title.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/widgets/fade_slide_transition.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  void _navigateToAllProducts() {
    if (Get.isRegistered<CategoryController>()) {
      Get.find<CategoryController>().openCategory("All");
    }
    if (Get.isRegistered<MainNavigationController>()) {
      Get.find<MainNavigationController>().changeIndex(1);
    }
  }

  Widget _buildProductListShimmer(BuildContext context) {
    return SizedBox(
      height: 270.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: AppColors.of(context).cardBackground,
          highlightColor: AppColors.primary.withValues(alpha: 0.1),
          child: Container(
            width: 165.w,
            decoration: BoxDecoration(
              color: AppColors.of(context).cardBackground,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeSlideTransition(index: 0, child: HomeAppBar()),

              SizedBox(height: 24.h),

              FadeSlideTransition(index: 2, child: HomeBannerSlider()),

              SizedBox(height: 20.h),

              FadeSlideTransition(
                index: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Categories", style: AppTextStyles.heading2),
                        const Spacer(),
                        TextButton(
                          onPressed: _navigateToAllProducts,
                          child: const Text("See All"),
                        ),
                      ],
                    ),
                    HomeCategories(),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              FadeSlideTransition(index: 5, child: const HomeHotDeals()),

              SizedBox(height: 20.h),

              FadeSlideTransition(
                index: 3,
                child: const BrandFeaturesSection(),
              ),

              SizedBox(height: 20.h),

              /// Main API content section
              Obx(() {
                if (controller.isLoading.value) {
                  return Column(
                    children: [
                      _buildProductListShimmer(context),
                      SizedBox(height: 20.h),
                      _buildProductListShimmer(context),
                    ],
                  );
                }

                if (controller.hasError.value) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 30.h,
                        horizontal: 20.w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off_rounded,
                            size: 48.sp,
                            color: AppColors.error,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            controller.errorMessage.value.isNotEmpty
                                ? controller.errorMessage.value
                                : 'Failed to load products',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.of(context).textPrimary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton.icon(
                            onPressed: () => controller.fetchHomeProducts(),
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (controller.allProducts.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Text(
                        'No products available right now.',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.of(context).textSecondary,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    /// Featured Products Section
                    if (controller.featuredProducts.isNotEmpty)
                      FadeSlideTransition(
                        index: 5,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: SectionTitle(
                                title: 'Featured Products',
                                onSeeAll: _navigateToAllProducts,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              height: 320.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.featuredProducts.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 0.w),
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                    product: controller.featuredProducts[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 20.h),

                    /// Best Sellers Section
                    if (controller.bestSellers.isNotEmpty)
                      FadeSlideTransition(
                        index: 6,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: SectionTitle(
                                title: 'Best Sellers',
                                onSeeAll: _navigateToAllProducts,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              height: 320.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.bestSellers.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 0.w),
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                    product: controller.bestSellers[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 20.h),

                    /// New Arrivals Section
                    if (controller.newArrivals.isNotEmpty)
                      FadeSlideTransition(
                        index: 7,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: SectionTitle(
                                title: 'New Arrivals',
                                onSeeAll: _navigateToAllProducts,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              height: 320.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.newArrivals.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 0.w),
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                    product: controller.newArrivals[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 20.h),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
