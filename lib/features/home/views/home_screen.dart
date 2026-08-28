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
    final colors = AppColors.of(context);
    return SizedBox(
      height: 280.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: colors.panelSecondary,
          highlightColor: colors.cardBackground,
          child: Container(
            width: 175.w,
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: colors.cardBackground,
          onRefresh: () async {
            controller.fetchHomeProducts();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top App Bar with Greeting & Search
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const FadeSlideTransition(
                      index: 0,
                      child: HomeAppBar(),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Carousel Banners
                  const FadeSlideTransition(
                    index: 1,
                    child: HomeBannerSlider(),
                  ),

                  SizedBox(height: 20.h),

                  // Categories Section
                  FadeSlideTransition(
                    index: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Explore Categories",
                                style: AppTextStyles.heading2.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                  color: colors.textPrimary,
                                ),
                              ),
                              TextButton(
                                onPressed: _navigateToAllProducts,
                                child: Text(
                                  "See All",
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
                        const HomeCategories(),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Limited Time Hot Deals
                  const FadeSlideTransition(
                    index: 3,
                    child: HomeHotDeals(),
                  ),

                  SizedBox(height: 24.h),

                  // Botanical & Ayurvedic Brand Features
                  const FadeSlideTransition(
                    index: 4,
                    child: BrandFeaturesSection(),
                  ),

                  SizedBox(height: 24.h),

                  /// Products from API
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
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: colors.cardBackground,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: colors.border),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_off_rounded,
                                  size: 44.sp,
                                  color: AppColors.error,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  controller.errorMessage.value.isNotEmpty
                                      ? controller.errorMessage.value
                                      : 'Failed to load products',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.body.copyWith(
                                    color: colors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  onPressed: () => controller.fetchHomeProducts(),
                                  icon: const Icon(Icons.refresh_rounded),
                                  label: const Text('Try Again'),
                                ),
                              ],
                            ),
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
                              color: colors.textSecondary,
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
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: SectionTitle(
                                    title: '✨ Featured Collections',
                                    onSeeAll: _navigateToAllProducts,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  height: 310.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    itemCount: controller.featuredProducts.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 4.w),
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

                        SizedBox(height: 24.h),

                        /// Best Sellers Section
                        if (controller.bestSellers.isNotEmpty)
                          FadeSlideTransition(
                            index: 6,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: SectionTitle(
                                    title: '🏆 Best Sellers',
                                    onSeeAll: _navigateToAllProducts,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  height: 310.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    itemCount: controller.bestSellers.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 4.w),
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

                        SizedBox(height: 24.h),

                        /// New Arrivals Section
                        if (controller.newArrivals.isNotEmpty)
                          FadeSlideTransition(
                            index: 7,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: SectionTitle(
                                    title: '🌿 New Arrivals',
                                    onSeeAll: _navigateToAllProducts,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  height: 310.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    itemCount: controller.newArrivals.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 4.w),
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
        ),
      ),
    );
  }
}
