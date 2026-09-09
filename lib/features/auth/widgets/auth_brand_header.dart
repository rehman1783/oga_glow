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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Increased header height for luxury spacious breathing room
    final headerHeight = widget.height ?? (275.h + topPadding * 0.55);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ClipPath(
        clipper: AuthWaveClipper(),
        child: Container(
          height: headerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: isDark
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0A1C0E), // Deep luxury obsidian night
                      Color(0xFF13321A), // Rich dark jade
                      Color(0xFF1E4826), // Luminous emerald
                    ],
                  )
                : const LinearGradient(
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
                right: -25.w,
                top: topPadding * 0.2,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Opacity(
                    opacity: isDark ? 0.16 : 0.12,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 240.w,
                      height: 240.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Soft champagne gold accent glow in dark mode
              if (isDark)
                Positioned(
                  top: -60.h,
                  right: -40.w,
                  child: Container(
                    width: 260.w,
                    height: 260.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFD4AF37).withValues(alpha: 0.10),
                          Colors.transparent,
                        ],
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
                        Colors.black.withValues(alpha: isDark ? 0.35 : 0.22),
                        Colors.transparent,
                        Colors.black.withValues(alpha: isDark ? 0.25 : 0.12),
                      ],
                    ),
                  ),
                ),
              ),

              // Back Button (if enabled)
              if (widget.showBackButton)
                Positioned(
                  top: topPadding + 8.h,
                  left: 18.w,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.onBack ?? () => Get.back(),
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: (isDark ? const Color(0xFF142B1B) : Colors.white)
                              .withValues(alpha: isDark ? 0.85 : 0.22),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: (isDark ? const Color(0xFF2C5936) : Colors.white)
                                .withValues(alpha: isDark ? 0.9 : 0.4),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
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

              // Title and Subtitle content with enhanced breathing room
              Positioned(
                bottom: 42.h,
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
                        fontSize: 27.sp,
                        letterSpacing: -0.4,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                            color: Colors.black.withValues(alpha: isDark ? 0.6 : 0.35),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark ? const Color(0xFFD6E8DA) : AppColors.white.withValues(alpha: 0.94),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        height: 1.35,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                            color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.25),
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
