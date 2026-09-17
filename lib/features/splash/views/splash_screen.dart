import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Ensure SplashController is registered
    if (!Get.isRegistered<SplashController>()) {
      Get.put(SplashController());
    }

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<double>(begin: 25.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _pulseAnimation = Tween<double>(begin: 0.94, end: 1.06).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF040E08)
          : const Color(0xFFFAF8F5),
      body: Stack(
        children: [
          // 1. Multi-Stop Radial & Linear Ambient Gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? const [
                          Color(0xFF030A05),
                          Color(0xFF06170E),
                          Color(0xFF0B2416),
                          Color(0xFF040F08),
                        ]
                      : const [
                          Color(0xFFFCFAF7),
                          Color(0xFFF7F3EB),
                          Color(0xFFEDE6D8),
                          Color(0xFFF9F7F2),
                        ],
                  stops: const [0.0, 0.35, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // 2. Soft Ambient Lighting Orbs (Non-intrusive glow)
          Positioned(
            top: -100.h,
            right: -80.w,
            child: Container(
              width: 320.w,
              height: 320.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.goldLight.withValues(alpha: isDark ? 0.15 : 0.22),
                    AppColors.gold.withValues(alpha: isDark ? 0.06 : 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -120.h,
            left: -100.w,
            child: Container(
              width: 360.w,
              height: 360.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.16),
                    AppColors.primaryLight.withValues(
                      alpha: isDark ? 0.10 : 0.06,
                    ),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // 3. Subtle Animated Center Brand Showcase
          Center(
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Jewel Emblem with Luxury Halo Rings
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Soft Outer Ambient Breathing Glow
                        Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            width: 170.w,
                            height: 170.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: isDark ? 0.35 : 0.20,
                                  ),
                                  blurRadius: 45,
                                  spreadRadius: 8,
                                ),
                                BoxShadow(
                                  color: AppColors.goldLight.withValues(
                                    alpha: isDark ? 0.25 : 0.28,
                                  ),
                                  blurRadius: 30,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Outer Concentric Golden Ring
                        Container(
                          width: 146.w,
                          height: 146.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.goldLight.withValues(
                                alpha: isDark ? 0.40 : 0.55,
                              ),
                              width: 1.2,
                            ),
                          ),
                        ),

                        // Inner Frosted Luxury Disc
                        Container(
                          width: 130.w,
                          height: 130.w,
                          padding: EdgeInsets.all(18.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isDark
                                  ? [
                                      const Color(
                                        0xFF0F2B1C,
                                      ).withValues(alpha: 0.9),
                                      const Color(
                                        0xFF06160D,
                                      ).withValues(alpha: 0.95),
                                    ]
                                  : [
                                      Colors.white.withValues(alpha: 0.95),
                                      const Color(
                                        0xFFF9F6EE,
                                      ).withValues(alpha: 0.9),
                                    ],
                            ),
                            border: Border.all(
                              color: AppColors.goldLight.withValues(
                                alpha: isDark ? 0.65 : 0.8,
                              ),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: isDark ? 0.4 : 0.08,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/brand_emblem.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.spa_rounded,
                                  color: AppColors.primary,
                                  size: 52.sp,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Brand Title: OGAGLOW with Metallic Gradient
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: isDark
                            ? const [
                                Color(0xFFFDFCF9),
                                Color(0xFFE8D499),
                                Color(0xFFC7A248),
                                Color(0xFFFFF6D8),
                              ]
                            : const [
                                Color(0xFF1B3B26),
                                Color(0xFF2E5A27),
                                Color(0xFF1B3B26),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      'OGAGLOW',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 7.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Botanical Divider with Center Diamond
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColors.goldLight.withValues(alpha: 0.6),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Icon(
                          Icons.auto_awesome,
                          size: 11.sp,
                          color: AppColors.goldLight,
                        ),
                      ),
                      Container(
                        width: 32.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.goldLight.withValues(alpha: 0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Luxury Tagline Capsule
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.goldLight.withValues(
                            alpha: isDark ? 0.15 : 0.20,
                          ),
                          AppColors.primary.withValues(
                            alpha: isDark ? 0.12 : 0.08,
                          ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: AppColors.goldLight.withValues(
                          alpha: isDark ? 0.35 : 0.45,
                        ),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      'AYURVEDIC BOTANICAL BEAUTY',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.2,
                        color: isDark
                            ? AppColors.goldLight
                            : const Color(0xFF533F02),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    'Pure Organic Skincare Rituals',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.6,
                      color: colors.textSecondary.withValues(alpha: 0.85),
                    ),
                  ),

                  SizedBox(height: 42.h),

                  // Minimalist Luxury Progress Capsule
                  SizedBox(
                    width: 130.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: colors.border.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: const LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Refined Bottom Brand Pledge & Version
          Positioned(
            bottom: 28.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.spa_outlined,
                      size: 13.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '100% PURE & CRUELTY-FREE',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                        color: colors.textSecondary.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  'CLINICALLY PROVEN AYURVEDIC FORMULAS • v1.0.0',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                    color: colors.textSecondary.withValues(alpha: 0.45),
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
