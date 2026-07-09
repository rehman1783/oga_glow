import 'package:get/get.dart';
import 'package:oga_glow/features/category/bindings/category_binding.dart';
import 'package:oga_glow/features/category/views/category_screen.dart';
import 'package:oga_glow/features/home/bindings/home_binding.dart';
import 'package:oga_glow/features/home/views/home_screen.dart';
import 'package:oga_glow/features/main_navigation/bindings/main_navigation_binding.dart';
import 'package:oga_glow/features/main_navigation/views/main_navigation_screen.dart';
import 'package:oga_glow/features/product/bindings/product_binding.dart';
import 'package:oga_glow/features/product/views/product_screen.dart';

import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/views/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
   GetPage(
  name: AppRoutes.mainNavigation,
  page: () => const MainNavigationScreen(),
  binding: MainNavigationBinding(),
),
GetPage(
  name: AppRoutes.category,
  page: () => const CategoryScreen(),
  binding: CategoryBinding(),
),
GetPage(
  name: AppRoutes.products,
  page: () => const ProductScreen(),
  binding: ProductBinding(),
),
GetPage(
  name: AppRoutes.products_details,
  page: () => const ProductScreen(),
  binding: ProductBinding(),
),
  ];
}