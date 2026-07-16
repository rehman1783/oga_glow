import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/views/cart_screen.dart';
import '../../category/views/category_screen.dart';
import '../../home/views/home_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../../wishlist/views/wishlist_screen.dart';
import '../controllers/main_navigation_controller.dart';
import '../../../core/theme/app_colors.dart';

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const CategoryScreen(),
      WishlistScreen(),
      CartScreen(),
      const ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBody: true, // Extends screen content behind the glass nav bar

        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeInOutQuad,
          switchOutCurve: Curves.easeInOutQuad,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.015, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: KeyedSubtree(
            key: ValueKey<int>(controller.currentIndex.value),
            child: screens[controller.currentIndex.value],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: AppColors.shadow2,
              borderRadius: AppColors.radius2,
            ),
            child: ClipRRect(
              borderRadius: AppColors.radius2,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: AppColors.panel,
                  child: NavigationBarTheme(
                    data: NavigationBarThemeData(
                      indicatorColor: AppColors.primary.withOpacity(0.12),
                      labelTextStyle: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          );
                        }
                        return TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        );
                      }),
                      iconTheme: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return const IconThemeData(
                            color: AppColors.primary,
                            size: 24,
                          );
                        }
                        return IconThemeData(color: AppColors.textSecondary, size: 22);
                      }),
                    ),
                    child: NavigationBar(
                      selectedIndex: controller.currentIndex.value,
                      onDestinationSelected: controller.changeIndex,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      height: 70,
                      destinations: const [
                        NavigationDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home_rounded),
                          label: "Home",
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.grid_view_outlined),
                          selectedIcon: Icon(Icons.grid_view_rounded),
                          label: "Category",
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.favorite_border_rounded),
                          selectedIcon: Icon(Icons.favorite_rounded),
                          label: "Wishlist",
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.shopping_cart_outlined),
                          selectedIcon: Icon(Icons.shopping_cart_rounded),
                          label: "Cart",
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.person_outline_rounded),
                          selectedIcon: Icon(Icons.person_rounded),
                          label: "Profile",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
