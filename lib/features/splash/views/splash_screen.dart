import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: Stack(
        children: [
          // Background Gradient with Ambient Glow
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? const [
                          Color(0xFF040A06),
                          Color(0xFF08140B),
                          Color(0xFF0D1F13),
                          Color(0xFF040A06),
                        ]
                      : const [
                          Color(0xFFFCFAF6),
                          Color(0xFFF7F3EA),
                          Color(0xFFECE5D5),
                          Color(0xFFFAF7F0),
                        ],
                  stops: const [0.0, 0.35, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Ambient Radial Light Orbs
          Positioned(
            top: -60.h,
            right: -60.w,
            child: Container(
              width: 240.w,
              height: 240.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.goldLight.withValues(alpha: isDark ? 0.12 : 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -80.h,
            left: -80.w,
            child: Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: isDark ? 0.18 : 0.14),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Floating Ambient Particles
          const FloatingBotanicalParticles(),

          // Centered Brand Showcase
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Breathing Logo with Luxury Halo
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1400),
                  tween: Tween(begin: 0.8, end: 1.0),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Pulsing Halo Glow
                      Container(
                        width: 220.w,
                        height: 220.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.16),
                              blurRadius: 50,
                              spreadRadius: 10,
                            ),
                            BoxShadow(
                              color: AppColors.goldLight.withValues(alpha: isDark ? 0.18 : 0.22),
                              blurRadius: 40,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),

                      // Logo Container with soft border
                      Container(
                        width: 170.w,
                        height: 170.w,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: colors.cardBackground.withValues(alpha: isDark ? 0.65 : 0.85),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.goldLight.withValues(alpha: 0.35),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28.h),

                // Brand Name with Spaced Luxury Serif
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1200),
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.easeIn,
                  builder: (context, opacity, child) {
                    return Opacity(
                      opacity: opacity,
                      child: child,
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        'OGA GLOW',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 6,
                          color: colors.textPrimary,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Botanical Alchemy Pill Tag
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.goldLight.withValues(alpha: 0.2),
                              AppColors.primary.withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColors.goldLight.withValues(alpha: 0.4),
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          '✦ BOTANICAL ALCHEMY ✦',
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                            color: isDark ? AppColors.goldLight : const Color(0xFF5A4400),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Text(
                        'Pure Ayurvedic Skincare & Rituals',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 12.5.sp,
                          color: colors.textSecondary.withValues(alpha: 0.8),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 36.h),

                // Minimalist Luxury Linear Progress Indicator
                SizedBox(
                  width: 120.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      minHeight: 2.5.h,
                      backgroundColor: colors.border.withValues(alpha: 0.5),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Footer Tag
          Positioned(
            bottom: 24.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.eco_outlined,
                      size: 13.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '100% PURE & CRUELTY-FREE',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: colors.textSecondary.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'v1.0.0',
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: colors.textSecondary.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingBotanicalParticles extends StatelessWidget {
  const FloatingBotanicalParticles({super.key});

  @override
  Widget build(BuildContext context) {
    final rand = Random(42);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final particleColors = [
      AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.15),
      AppColors.primaryLight.withValues(alpha: isDark ? 0.2 : 0.12),
      AppColors.goldLight.withValues(alpha: isDark ? 0.25 : 0.18),
    ];

    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          return Stack(
            children: List.generate(18, (index) {
              final top = rand.nextDouble() * height;
              final left = rand.nextDouble() * width;
              final size = rand.nextDouble() * 6 + 3;
              final color = particleColors[index % particleColors.length];

              return Positioned(
                top: top,
                left: left,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color,
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
