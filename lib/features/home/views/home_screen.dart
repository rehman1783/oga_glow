import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import 'package:oga_glow/features/home/widgets/home_app_bar.dart';
import 'package:oga_glow/features/home/widgets/home_banner_slider.dart';
import 'package:oga_glow/features/home/widgets/home_categories.dart';
import 'package:oga_glow/features/home/widgets/home_hot_deals.dart';
import 'package:oga_glow/features/home/widgets/home_search_bar.dart';
import 'package:oga_glow/features/home/widgets/product_card.dart';
import 'package:oga_glow/features/home/widgets/section_title.dart';
import '../../../core/widgets/fade_slide_transition.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                FadeSlideTransition(
                  index: 0,
                  child: HomeAppBar(),
                ),

                SizedBox(height: 20.h),

                FadeSlideTransition(
                  index: 1,
                  child: HomeSearchBar(),
                ),

                SizedBox(height: 24.h),

                FadeSlideTransition(
                  index: 2,
                  child: HomeBannerSlider(),
                ),

                const SizedBox(height: 30),

                FadeSlideTransition(
                  index: 3,
                  child: HomeCategories(),
                ),

                const SizedBox(height: 20),

                FadeSlideTransition(
                  index: 4,
                  child: const HomeHotDeals(),
                ),

                const SizedBox(height: 20),

                FadeSlideTransition(
                  index: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SectionTitle(
                          title: 'Featured Products',
                          onSeeAll: () {
                            Get.toNamed(
                              AppRoutes.allProducts,
                              arguments: {'category': 'All'},
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 280.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.featuredProducts.length,
                          separatorBuilder: (_, __) => SizedBox(width: 0.w),
                          itemBuilder: (context, index) {
                            final product = controller.featuredProducts[index];
                            return ProductCard(
                              name: product['name']!,
                              price: product['price']!,
                              image: product['image']!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20.h),
                
                FadeSlideTransition(
                  index: 6,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SectionTitle(
                          title: 'Best Sellers',
                          onSeeAll: () {
                            Get.toNamed(
                              AppRoutes.allProducts,
                              arguments: {'category': 'All'},
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                      SizedBox(
                        height: 280.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.bestSellers.length,
                          separatorBuilder: (_, __) => SizedBox(width: 0.w),
                          itemBuilder: (context, index) {
                            final product = controller.bestSellers[index];
                            return ProductCard(
                              name: product['name']!,
                              price: product['price']!,
                              image: product['image']!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
                
                FadeSlideTransition(
                  index: 7,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SectionTitle(
                          title: 'New Arrivals',
                          onSeeAll: () {
                            Get.toNamed(
                              AppRoutes.allProducts,
                              arguments: {'category': 'All'},
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                      SizedBox(
                        height: 280.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.newArrivals.length,
                          separatorBuilder: (_, __) => SizedBox(width: 0.w),
                          itemBuilder: (context, index) {
                            final product = controller.newArrivals[index];
                            return ProductCard(
                              name: product['name']!,
                              price: product['price']!,
                              image: product['image']!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
