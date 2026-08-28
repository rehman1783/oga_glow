import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../main_navigation/controllers/main_navigation_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning ☀️';
    if (hour < 17) return 'Good Afternoon 🌤️';
    return 'Good Evening 🌙';
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: Column(
        children: [
          Row(
            children: [
              // Drawer Menu Button
              BounceTap(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: colors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.widgets_outlined,
                    color: colors.textPrimary,
                    size: 20.sp,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // User Info & Greeting
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(),
                      style: AppTextStyles.caption.copyWith(
                        color: colors.textSecondary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Obx(() {
                      String displayName = 'OGA Glow';
                      if (Get.isRegistered<AuthController>()) {
                        final user = Get.find<AuthController>().currentUser.value;
                        if (user != null && user.name.isNotEmpty) {
                          displayName = user.name.split(' ').first;
                        }
                      }
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.heading2.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.primaryLight],
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'GLOW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),

              // Search Button
              BounceTap(
                onTap: () {
                  if (Get.isRegistered<MainNavigationController>()) {
                    Get.find<MainNavigationController>().changeIndex(1); // Category & Search
                  }
                },

                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: colors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.search_rounded,
                    color: colors.textPrimary,
                    size: 20.sp,
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Notification Button with luxury unread dot
              BounceTap(
                onTap: () {},
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: colors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        color: colors.textPrimary,
                        size: 21.sp,
                      ),
                      Positioned(
                        top: 10.h,
                        right: 10.w,
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryLight],
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.cardBackground,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
