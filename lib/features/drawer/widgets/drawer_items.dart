import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../main_navigation/controllers/main_navigation_controller.dart';

class DrawerProfileItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final String? onTapRoute;

  const DrawerProfileItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTapRoute,
  });

  int? _indexForRoute(String route) {
    // When drawer uses mainNavigation for both tiles, map by title/route.
    // We keep old mappings too for safety.
    if (route == AppRoutes.wishlist) return 2;
    if (route == AppRoutes.cart) return 3;

    if (route == AppRoutes.mainNavigation) {
      if (title.toLowerCase().contains('wish')) return 2;
      if (title.toLowerCase().contains('cart')) return 3;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).pop();

          if (onTapRoute != null) {
            final index = _indexForRoute(onTapRoute!);

            Get.toNamed(onTapRoute!);
            if (index != null) {
              // ensure navigation frame is built before changing tab
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Get.isRegistered<MainNavigationController>()) {
                  Get.find<MainNavigationController>().changeIndex(index);
                }
              });
            }
            return;
          }
          // fallback
          Get.toNamed(AppRoutes.profile);
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: theme.colorScheme.primary, size: 24),
                child: icon,
              ),

              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    // fontWeight: FontWeight.w600,
                    letterSpacing: .2,
                  ),
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: theme.hintColor,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
