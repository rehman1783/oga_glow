import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.bgLight,
              AppColors.secondary,
              Color(0xFFE2EAD6), // Extremely soft olive mix
              AppColors.bgLight,
            ],
            stops: [0.0, 0.4, 0.8, 1.0],
          ),
        ),
        child: Stack(
          children: [
            const FloatingParticles(),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 2),
                    tween: Tween(begin: 0, end: 2 * pi),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value * 0.03,
                        child: child,
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(.18),
                                blurRadius: 50,
                                spreadRadius: 15,
                              ),
                              BoxShadow(
                                color: AppColors.primaryLight.withOpacity(.12),
                                blurRadius: 80,
                                spreadRadius: 30,
                              ),
                            ],
                          ),
                        ),

                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 1500),
                          tween: Tween(begin: 0.0, end: 1.0),
                          curve: Curves.easeIn,
                          builder: (context, opacity, child) {
                            return Opacity(opacity: opacity, child: child);
                          },
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 260,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  // App name
                  Text(
                    'Oga Glow',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tagline
                  Text(
                    'Professional & Elegant',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Shimmer tagline in brand matching shades
                  Shimmer.fromColors(
                    baseColor: AppColors.primary,
                    highlightColor: AppColors.primaryLight,
                    child: const Text(
                      "FRESH & NATURAL",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: 35,
                    height: 35,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Shimmer.fromColors(
                    baseColor: AppColors.textSecondary.withOpacity(0.5),
                    highlightColor: AppColors.primaryLight,
                    child: const Text(
                      "LOADING...",
                      style: TextStyle(
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingParticles extends StatelessWidget {
  const FloatingParticles({super.key});

  @override
  Widget build(BuildContext context) {
    // Brand colors to pick from randomly
    final List<Color> brandColors = [
      AppColors.primary,
      AppColors.primaryLight,
      AppColors.accent,
      AppColors.secondary,
    ];

    return Stack(
      children: List.generate(
        25,
        (index) => Positioned(
          top: Random().nextDouble() * 800,
          left: Random().nextDouble() * 400,
          child: Container(
            width: Random().nextDouble() * 8 + 4,
            height: Random().nextDouble() * 8 + 4,
            decoration: BoxDecoration(
              color: brandColors[index % brandColors.length].withOpacity(.35),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
