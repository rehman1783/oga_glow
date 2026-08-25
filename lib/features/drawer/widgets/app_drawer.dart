import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/auth/controllers/auth_controller.dart';
import 'drawer_items.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Drawer(
      backgroundColor: colors.cardBackground,
      child: SafeArea(
        child: Column(
          children: [
            // Branded Dynamic User Header
            Obx(() {
              final authController = Get.find<AuthController>();
              final user = authController.currentUser.value;
              final name = (user?.name != null && user!.name.isNotEmpty)
                  ? user.name
                  : 'OGA Glow Customer';
              final email = (user?.email != null && user!.email.isNotEmpty)
                  ? user.email
                  : 'hello@ogaglow.com';
              final initial = name.isNotEmpty ? name[0].toUpperCase() : 'O';

              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.primaryLight.withValues(alpha: 0.08),
                      colors.cardBackground,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: colors.border.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        initial,
                        style: AppTextStyles.heading1.copyWith(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading2.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption.copyWith(
                              color: colors.textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            // Navigation Menu Options
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                children: [
                  DrawerItem(
                    title: 'My Profile',
                    icon: const Icon(Icons.person_outline_rounded),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.profile);
                    },
                  ),
                  const Divider(height: 1),
                  DrawerItem(
                    title: 'My Orders',
                    icon: const Icon(Icons.receipt_long_rounded),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.orderHistory);
                    },
                  ),
                  const Divider(height: 1),
                  DrawerItem(
                    title: 'Contact Us',
                    icon: const Icon(Icons.headset_mic_outlined),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.contact);
                    },
                  ),
                  const Divider(height: 1),
                  DrawerItem(
                    title: 'About OGA Glow',
                    icon: const Icon(Icons.spa_outlined),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.about);
                    },
                  ),
                  const Divider(height: 1),
                  DrawerItem(
                    title: 'FAQ & Help',
                    icon: const Icon(Icons.help_outline_rounded),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.faq);
                    },
                  ),
                  const Divider(height: 1),
                  DrawerItem(
                    title: 'Legal & Policies',
                    icon: const Icon(Icons.gavel_rounded),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.legal);
                    },
                  ),
                ],
              ),
            ),

            // Footer Brand Tag
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.eco_rounded,
                    size: 16.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'OGA Glow • Pure & Natural',
                    style: AppTextStyles.caption.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

