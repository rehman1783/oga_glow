import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GlowBackground extends StatefulWidget {
  const GlowBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GlowBackground> createState() => _GlowBackgroundState();
}

class _GlowBackgroundState extends State<GlowBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = AppColors.primary;
    final secondaryColor = AppColors.primaryLight;
    final accentColor = AppColors.accent;

    return Stack(
      children: [
        // Solid background base
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),

        // Animated glowing blobs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final progress = _controller.value * 2 * pi;

            // Compute positions with smooth sine/cosine waves
            final blob1X = size.width * 0.1 + sin(progress) * 40;
            final blob1Y = size.height * 0.15 + cos(progress) * 50;

            final blob2X = size.width * 0.5 + cos(progress + pi / 2) * 50;
            final blob2Y = size.height * 0.55 + sin(progress + pi / 2) * 60;

            final blob3X = size.width * 0.2 + sin(progress + pi) * 60;
            final blob3Y = size.height * 0.75 + cos(progress + pi) * 40;

            return Stack(
              children: [
                // Blob 1 (Top Left - Olive Green)
                Positioned(
                  left: blob1X - 150,
                  top: blob1Y - 150,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          primaryColor.withValues(alpha: 0.15),
                          primaryColor.withValues(alpha: 0.04),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),

                // Blob 2 (Middle Right - Cream/Secondary Light)
                Positioned(
                  left: blob2X - 120,
                  top: blob2Y - 120,
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          secondaryColor.withValues(alpha: 0.2),
                          secondaryColor.withValues(alpha: 0.05),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),

                // Blob 3 (Bottom Left - Herbal Brown)
                Positioned(
                  left: blob3X - 160,
                  top: blob3Y - 160,
                  child: Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          accentColor.withValues(alpha: 0.08),
                          accentColor.withValues(alpha: 0.02),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Foreground content
        Positioned.fill(
          child: widget.child,
        ),
      ],
    );
  }
}
