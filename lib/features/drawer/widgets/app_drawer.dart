import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';

import '../../../app/routes/app_routes.dart';

import '../../../core/theme/app_colors.dart';

import 'drawer_items.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OGA Glow',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'profile@oga.glow',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),

            DrawerItem(
              title: 'Profile',
              icon: Icon(Icons.shopping_cart_outlined),
              onTap: () {
                Get.toNamed(AppRoutes.profile);
              },
            ),
            Divider(),
            DrawerItem(
              title: "Wishlist",
              icon: Icon(Icons.favorite_border),
              onTap: () {
                Get.find<MainNavigationController>().changeIndex(2);
              },
            ),
            Divider(),
            DrawerItem(
              title: "Cart",
              icon: Icon(Icons.shopping_cart_outlined),
              onTap: () {
                Get.find<MainNavigationController>().changeIndex(3);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
