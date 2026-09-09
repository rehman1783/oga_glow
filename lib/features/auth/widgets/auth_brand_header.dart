import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'auth_wave_clipper.dart';

class AuthBrandHeader extends StatefulWidget {
  const AuthBrandHeader({
    super.key,
    this.title = 'OGA Glow',
    this.subtitle = 'Welcome back! Please sign in.',
    this.showBackButton = false,
    this.onBack,
    this.height,
  });

  final String title;
  final String subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final double? height;

  @override
  State<AuthBrandHeader> createState() => _AuthBrandHeaderState();
}

class _AuthBrandHeaderState extends State<AuthBrandHeader>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _breathController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Entrance fade-in animation
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );
    _entranceController.forward();

    // Subtle breathing animation for the background pattern
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(
        parent: _breathController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final headerHeight = widget.height ?? (230.h + topPadding * 0.4);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ClipPath(
        clipper: AuthWaveClipper(),
        child: Container(
          height: headerHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                Color(0xFF3F6E35),
                AppColors.primaryLight,
              ],
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              // Subtle luxury botanical emblem/logo in background
              Positioned(
                right: -30.w,
                top: -10.h,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Opacity(
                    opacity: 0.12,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 220.w,
                      height: 220.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Soft vignette overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.25),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.12),
                      ],
                    ),
                  ),
                ),
              ),

              // Back Button (if enabled)
              if (widget.showBackButton)
                Positioned(
                  top: topPadding + 10.h,
                  left: 18.w,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.onBack ?? () => Get.back(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.35),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),

              // Title and Subtitle content
              Positioned(
                bottom: 34.h,
                left: 24.w,
                right: 24.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                        fontSize: 26.sp,
                        letterSpacing: -0.3,
                        shadows: const [
                          Shadow(
                            blurRadius: 6,
                            offset: Offset(0, 2),
                            color: Color(0x50000000),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.92),
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp,
                        height: 1.3,
                        shadows: const [
                          Shadow(
                            blurRadius: 4,
                            offset: Offset(0, 1),
                            color: Color(0x35000000),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
