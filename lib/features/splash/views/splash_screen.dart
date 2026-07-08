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
              Color(0xFFE0F7FA), // Light cyan
              Color(0xFF80DEEA), // Cyan
              Color(0xFF26C6DA), // Darker cyan
              Color(0xFF00ACC1), // Teal
            ],
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
                                color: Colors.pink.withOpacity(.25),
                                blurRadius: 50,
                                spreadRadius: 15,
                              ),
                              BoxShadow(
                                color: Colors.orange.withOpacity(.15),
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
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tagline
                  Text(
                    'Professional & Elegant',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Existing shimmer tagline
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.white,
                    child: const Text(
                      "FRESH & NATURAL",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

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
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
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

            const Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.black54, fontSize: 12),
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
    return Stack(
      children: List.generate(
        20,
        (index) => Positioned(
          top: Random().nextDouble() * 800,
          left: Random().nextDouble() * 400,
          child: Container(
            width: Random().nextDouble() * 8 + 4,
            height: Random().nextDouble() * 8 + 4,
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length]
                  .withOpacity(.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
