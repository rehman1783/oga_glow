import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/views/cart_screen.dart';
import '../../category/views/category_screen.dart';
import '../../home/views/home_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../../wishlist/views/wishlist_screen.dart';
import '../controllers/main_navigation_controller.dart';

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final screens = [
      const HomeScreen(),
      const CategoryScreen(),
       WishlistScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        body: screens[controller.currentIndex.value],

        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.currentIndex.value,

          onDestinationSelected: controller.changeIndex,

          destinations: const [

            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home",
            ),

            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view),
              label: "Category",
            ),

            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: "Wishlist",
            ),

            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),

            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}