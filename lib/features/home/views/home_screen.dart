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
import 'package:oga_glow/features/home/widgets/home_search_bar.dart';
import 'package:oga_glow/features/home/widgets/product_card.dart';
import 'package:oga_glow/features/home/widgets/section_title.dart';

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
                HomeAppBar(),

                SizedBox(height: 20.h),

                HomeSearchBar(),

                SizedBox(height: 24.h),

                HomeBannerSlider(),

                const SizedBox(height: 30),

                HomeCategories(),

                const SizedBox(height: 20),

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
                    // padding: EdgeInsets.symmetric(horizontal: 08.w),
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
                SizedBox(height: 20.h),
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
                    // padding: EdgeInsets.symmetric(horizontal: 0.w),
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

                SizedBox(height: 20.h),
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
                    // padding: EdgeInsets.symmetric(horizontal: 8.w),
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

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
