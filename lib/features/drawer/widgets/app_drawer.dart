import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';

import '../../../app/routes/app_routes.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

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
                color: AppColors.primary.withValues(alpha: 0.08),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OGA Glow',
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'profile@oga.glow',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.of(context).textSecondary,
                      ),
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
              title: 'My Orders',
              icon: const Icon(Icons.receipt_long_rounded),
              onTap: () {
                Get.toNamed(AppRoutes.orderHistory);
              },
            ),
            const Divider(),
            DrawerItem(
              title: 'About Us',
              icon: const Icon(Icons.info_outline_rounded),
              onTap: () {
                Get.toNamed(AppRoutes.about);
              },
            ),
            const Divider(),
            DrawerItem(
              title: 'Contact Us',
              icon: const Icon(Icons.headset_mic_outlined),
              onTap: () {
                Get.toNamed(AppRoutes.contact);
              },
            ),
            const Divider(),
            DrawerItem(
              title: 'FAQ',
              icon: const Icon(Icons.help_outline_rounded),
              onTap: () {
                Get.toNamed(AppRoutes.faq);
              },
            ),
            const Divider(),
            DrawerItem(
              title: 'Legal & Compliance',
              icon: const Icon(Icons.gavel_rounded),
              onTap: () {
                Get.toNamed(AppRoutes.legal);
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
