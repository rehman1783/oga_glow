import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            DrawerProfileItem(
              title: 'Wishlist',
              icon: Icon(Icons.favorite_border_rounded),
              onTapRoute: AppRoutes.mainNavigation,
            ),
            Divider(),
            DrawerProfileItem(
              title: 'Cart',
              icon: Icon(Icons.shopping_cart_outlined),
              onTapRoute: AppRoutes.mainNavigation,
            ),
            Divider(),
            DrawerProfileItem(
              title: 'Profile',
              icon: Icon(Icons.person_outline_rounded),
              onTapRoute: AppRoutes.profile,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
