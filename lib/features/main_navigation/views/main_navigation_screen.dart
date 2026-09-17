import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../cart/views/cart_screen.dart';
import '../../category/views/category_screen.dart';
import '../../home/views/home_screen.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../../wishlist/views/wishlist_screen.dart';
import '../controllers/main_navigation_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../drawer/widgets/app_drawer.dart';

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final screens = [
      const HomeScreen(),
      const CategoryScreen(),
      WishlistScreen(),
      CartScreen(),
    ];

    return Obx(
      () => PopScope(
        canPop: controller.currentIndex.value == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (controller.currentIndex.value != 0) {
            controller.changeIndex(0);
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: const AppDrawer(),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.012, 0.0),
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
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            color: Colors.transparent,
            child: Container(
              height: 66.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(26.r),
                border: Border.all(
                  color: colors.border.withValues(alpha: 0.9),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(
                    context: context,
                    index: 0,
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home_rounded,
                    label: 'Home',
                  ),
                  _navItem(
                    context: context,
                    index: 1,
                    icon: Icons.grid_view_outlined,
                    selectedIcon: Icons.grid_view_rounded,
                    label: 'Categories',
                  ),
                  _navItem(
                    context: context,
                    index: 2,
                    icon: Icons.favorite_border_rounded,
                    selectedIcon: Icons.favorite_rounded,
                    label: 'Wishlist',
                    badgeCountRx: Get.isRegistered<WishlistController>(tag: WishlistController.tag)
                        ? Get.find<WishlistController>(tag: WishlistController.tag).wishlistItems.length
                        : 0,
                  ),
                  _navItem(
                    context: context,
                    index: 3,
                    icon: Icons.shopping_bag_outlined,
                    selectedIcon: Icons.shopping_bag_rounded,
                    label: 'Cart',
                    badgeCountRx: Get.isRegistered<CartController>(tag: CartController.tag)
                        ? Get.find<CartController>(tag: CartController.tag).cartItems.length
                        : 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    int? badgeCountRx,
  }) {
    final colors = AppColors.of(context);
    final isSelected = controller.currentIndex.value == index;

    return BounceTap(
      scaleBound: 0.88,
      onTap: () => controller.changeIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.w : 12.w,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    AppColors.primaryLight.withValues(alpha: 0.08),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(18.r),
          border: isSelected
              ? Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1.0,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? selectedIcon : icon,
                  size: 22.sp,
                  color: isSelected ? AppColors.primary : colors.textSecondary,
                ),
                if (badgeCountRx != null && badgeCountRx > 0)
                  Positioned(
                    top: -4.h,
                    right: -6.w,
                    child: Container(
                      padding: EdgeInsets.all(3.5.r),
                      decoration: const BoxDecoration(
                        gradient: AppColors.redGradient,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(minWidth: 14.w, minHeight: 14.w),
                      alignment: Alignment.center,
                      child: Text(
                        '$badgeCountRx',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
