import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_option_tile.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../../core/widgets/fade_slide_transition.dart';
import '../../../core/theme/theme_controller.dart';
import 'profile_screen_theme_option.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: AppTextStyles.heading2.copyWith(fontSize: 18),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            children: [
              FadeSlideTransition(
                index: 0,
                child: ProfileHeaderCard(
                  name: 'OGA Glow',
                  email: 'oga.glow@example.com',
                  onEdit: () {
                    Get.snackbar(
                      'Edit Profile',
                      'Edit profile UI will be connected to controller later.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.cardBackground,
                      colorText: Theme.of(context).colorScheme.onSurface,
                      borderRadius: 14.r,
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),

              // Options
              Column(
                children: [
                  FadeSlideTransition(
                    index: 1,
                    child: ProfileOptionTile(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      onTap: () {
                        Get.snackbar(
                          'My Orders',
                          'Orders screen is not wired yet in this demo.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.cardBackground,
                          colorText: AppColors.textPrimary,
                          borderRadius: 14.r,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),

                  FadeSlideTransition(
                    index: 2,
                    child: ProfileOptionTile(
                      icon: Icons.location_on_outlined,
                      title: 'Shipping Address',
                      onTap: () {
                        Get.snackbar(
                          'Shipping Address',
                          'Address screen will be wired with routing later.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.cardBackground,
                          colorText: AppColors.textPrimary,
                          borderRadius: 14.r,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),

                  FadeSlideTransition(
                    index: 3,
                    child: ProfileOptionTile(
                      icon: Icons.favorite_border_outlined,
                      title: 'Wishlist',
                      onTap: () {
                        Get.toNamed('/wishlist');
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),

                  FadeSlideTransition(
                    index: 4,
                    child: ProfileOptionTile(
                      icon: Icons.shopping_cart_outlined,
                      title: 'Cart',
                      onTap: () {
                        Get.toNamed('/cart');
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),

                  FadeSlideTransition(
                    index: 5,
                    child: ProfileOptionTile(
                      icon: Icons.brightness_6_outlined,
                      title: 'Theme Mode',
                      onTap: () async {
                        final themeController = Get.find<ThemeController>();

                        await Get.bottomSheet(
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(18.r),
                              ),
                            ),
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Theme mode',
                                  style: AppTextStyles.heading2.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                ProfileThemeModeOption(
                                  title: 'System',
                                  value: ThemeMode.system,
                                  groupValue: themeController.themeMode.value,
                                  onSelected: (mode) async {
                                    await themeController.setThemeMode(mode);
                                    Get.back();
                                  },
                                ),
                                SizedBox(height: 10.h),
                                ProfileThemeModeOption(
                                  title: 'Light',
                                  value: ThemeMode.light,
                                  groupValue: themeController.themeMode.value,
                                  onSelected: (mode) async {
                                    await themeController.setThemeMode(mode);
                                    Get.back();
                                  },
                                ),
                                SizedBox(height: 10.h),
                                ProfileThemeModeOption(
                                  title: 'Dark',
                                  value: ThemeMode.dark,
                                  groupValue: themeController.themeMode.value,
                                  onSelected: (mode) async {
                                    await themeController.setThemeMode(mode);
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),
              FadeSlideTransition(
                index: 6,
                child: Divider(color: AppColors.border.withOpacity(0.5)),
              ),
              SizedBox(height: 20.h),

              // Logout / Delete
              FadeSlideTransition(
                index: 7,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: BounceTap(
                        onTap: () {
                          Get.snackbar(
                            'Logout',
                            'Logout action will be wired with auth controller.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Theme.of(context).cardColor,
                            colorText: AppColors.textPrimary,
                            borderRadius: 14.r,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: AppColors.accent.withOpacity(0.35),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.logout_rounded,
                                color: AppColors.accent,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Logout',
                                style: AppTextStyles.button.copyWith(
                                  color: AppColors.accent,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: BounceTap(
                        onTap: () {
                          Get.snackbar(
                            'Delete Account',
                            'Delete account action is a placeholder.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Theme.of(context).cardColor,
                            colorText: Theme.of(context).colorScheme.onSurface,
                            borderRadius: 14.r,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: AppColors.error.withOpacity(0.4),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.error,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Delete Account',
                                style: AppTextStyles.button.copyWith(
                                  color: AppColors.error,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 26.h),
            ],
          ),
        ),
      ),
    );
  }
}
