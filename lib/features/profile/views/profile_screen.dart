import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile', style: AppTextStyles.heading2),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            children: [
              ProfileHeaderCard(
                name: 'OGA Glow',
                email: 'oga.glow@example.com',
                onEdit: () {
                  Get.snackbar(
                    'Edit Profile',
                    'Edit profile UI will be connected to controller later.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.cardBackground,
                    colorText: AppColors.textPrimary,
                    borderRadius: 14.r,
                  );
                },
              ),
              SizedBox(height: 14.h),

              // Options
              Column(
                children: [
                  ProfileOptionTile(
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
                  SizedBox(height: 12.h),
                  ProfileOptionTile(
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
                  SizedBox(height: 12.h),
                  ProfileOptionTile(
                    icon: Icons.favorite_border_outlined,
                    title: 'Wishlist',
                    onTap: () {
                      Get.toNamed('/wishlist');
                    },
                  ),
                  SizedBox(height: 12.h),
                  ProfileOptionTile(
                    icon: Icons.shopping_cart_outlined,
                    title: 'Cart',
                    onTap: () {
                      Get.toNamed('/cart');
                    },
                  ),
                  SizedBox(height: 12.h),
                  ProfileOptionTile(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Get.snackbar(
                        'Settings',
                        'Settings page is not implemented yet.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.cardBackground,
                        colorText: AppColors.textPrimary,
                        borderRadius: 14.r,
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 18.h),
              Divider(color: AppColors.border),
              SizedBox(height: 16.h),

              // Logout / Delete
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar(
                      'Logout',
                      'Logout action will be wired with auth controller.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.cardBackground,
                      colorText: AppColors.textPrimary,
                      borderRadius: 14.r,
                    );
                  },
                  icon: const Icon(Icons.logout_rounded),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.accent,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      side: BorderSide(color: AppColors.accent.withOpacity(0.45)),
                    ),
                  ),
                  label: Text(
                    'Logout',
                    style: AppTextStyles.button.copyWith(color: AppColors.accent),
                  ),
                ),
              ),

              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Get.snackbar(
                      'Delete Account',
                      'Delete account action is a placeholder.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.cardBackground,
                      colorText: AppColors.textPrimary,
                      borderRadius: 14.r,
                    );
                  },
                  icon: const Icon(Icons.delete_outline_rounded),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: BorderSide(color: AppColors.error.withOpacity(0.45)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  label: Text(
                    'Delete Account',
                    style: AppTextStyles.button.copyWith(color: AppColors.error),
                  ),
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

