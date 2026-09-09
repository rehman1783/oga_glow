import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/glow_background.dart';
import '../widgets/fade_slide_transition.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../app/routes/app_routes.dart';

class AuthEntryScreen extends StatelessWidget {
  const AuthEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentGreen = isDark ? AppColors.primaryLight : AppColors.primary;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlowBackground(
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              /// Top Brand Header
              const AuthBrandHeader(
                title: 'OGA Glow',
                subtitle: 'Discover Your Natural Radiance',
              ),

              /// Bottom Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),

                      FadeSlideTransition(
                        index: 1,
                        child: Text(
                          "Pure Botanical Skincare",
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      FadeSlideTransition(
                        index: 2,
                        child: Text(
                          "Discover nature's finest formulations designed to restore, nourish, and elevate your skin and hair routine.",
                          style: AppTextStyles.body.copyWith(
                            color: colors.textSecondary,
                            fontSize: 14.sp,
                            height: 1.5,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Feature Pills
                      FadeSlideTransition(
                        index: 3,
                        child: Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: const [
                            _PillTag(icon: '🌿', label: '100% Organic'),
                            _PillTag(icon: '✨', label: 'Clinically Tested'),
                            _PillTag(icon: '🐰', label: 'Cruelty-Free'),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Primary CTA: Get Started / Create Account
                      FadeSlideTransition(
                        index: 4,
                        child: SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed(AppRoutes.signup),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? const Color(0xFF326330) : AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shadowColor: (isDark ? const Color(0xFF5AA34B) : AppColors.primary).withValues(alpha: isDark ? 0.4 : 0.35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Get Started",
                                  style: AppTextStyles.button.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Secondary CTA: Sign In
                      FadeSlideTransition(
                        index: 5,
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: OutlinedButton(
                            onPressed: () => Get.toNamed(AppRoutes.login),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: isDark ? const Color(0xFF102015) : colors.cardBackground,
                              side: BorderSide(
                                color: isDark ? accentGreen : AppColors.primary.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              "I already have an account",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: accentGreen,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.5.sp,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Tertiary Option: Explore as Guest
                      FadeSlideTransition(
                        index: 6,
                        child: Center(
                          child: TextButton(
                            onPressed: () => Get.offAllNamed(AppRoutes.mainNavigation),
                            child: Text(
                              "Explore as Guest",
                              style: TextStyle(
                                color: isDark ? const Color(0xFF9EBEA5) : colors.textSecondary,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 14.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillTag extends StatelessWidget {
  const _PillTag({
    required this.icon,
    required this.label,
  });

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF102015) : colors.panel,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF22422A) : colors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: 12.sp)),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
