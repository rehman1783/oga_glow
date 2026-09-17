import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'auth_wave_clipper.dart';

class AuthBrandHeader extends StatefulWidget {
  const AuthBrandHeader({
    super.key,
    this.title = 'OGAGLOW',
    this.subtitle = 'Welcome back! Please sign in.',
    this.showBackButton = false,
    this.onBack,
    this.height,
    this.showLogo = false,
  });

  final String title;
  final String subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final double? height;
  final bool showLogo;

  @override
  State<AuthBrandHeader> createState() => _AuthBrandHeaderState();
}

class _AuthBrandHeaderState extends State<AuthBrandHeader>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _glowController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Entrance fade & slide animation
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<double>(begin: 30.h, end: 0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.elasticOut),
    );

    _entranceController.forward();

    // Subtle breathing glow animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Height calculation based on whether logo is shown
    final defaultHeight = widget.showLogo
        ? (340.h + topPadding * 0.75)
        : (295.h + topPadding * 0.75);
    final headerHeight = widget.height ?? defaultHeight;

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
                      Color(0xFF07170B), // Deepest luxury emerald obsidian
                      Color(0xFF0F3218), // Rich dark botanical green
                      Color(0xFF184824), // Luminous emerald accent
                    ],
                    stops: [0.0, 0.55, 1.0],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1B4323), // Deep forest emerald
                      Color(0xFF2E6B37), // Primary brand green
                      Color(0xFF42884E), // Luminous botanical light
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              // Ambient Gold & Emerald Radial Glow Spots
              Positioned(
                top: -40.h,
                right: -30.w,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 260.w,
                    height: 260.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFD4AF37).withValues(
                            alpha: isDark ? 0.18 : 0.22,
                          ), // Champagne gold
                          const Color(0xFF2E6B37).withValues(alpha: 0.10),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: -20.h,
                left: -40.w,
                child: Container(
                  width: 220.w,
                  height: 220.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primaryLight.withValues(
                          alpha: isDark ? 0.15 : 0.2,
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Subtle Background Watermark (Brand Emblem)
              Positioned(
                right: -20.w,
                bottom: 10.h,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Opacity(
                    opacity: isDark ? 0.08 : 0.07,
                    child: Image.asset(
                      'assets/images/brand_emblem.png',
                      width: 230.w,
                      height: 230.h,
                      fit: BoxFit.contain,
                      errorBuilder: (ctx, err, stack) => Image.asset(
                        'assets/images/logo.png',
                        width: 230.w,
                        height: 230.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              // Luxury Overlay Vignette
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: isDark ? 0.30 : 0.15),
                        Colors.transparent,
                        Colors.black.withValues(alpha: isDark ? 0.20 : 0.08),
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
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color:
                              (isDark ? const Color(0xFF14301B) : Colors.white)
                                  .withValues(alpha: isDark ? 0.75 : 0.22),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(
                              0xFFD4AF37,
                            ).withValues(alpha: 0.45),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
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

              // Header Main Content (Logo Badge + Brand Label + Title + Subtitle)
              Positioned(
                bottom: 90.h,
                left: 24.w,
                right: 24.w,
                child: AnimatedBuilder(
                  animation: _entranceController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: child,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Prominent Luxury Logo Showcase Container
                      if (widget.showLogo) ...[
                        ScaleTransition(
                          scale: _logoScaleAnimation,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFE5C158), // Champagne gold accent
                                  Color(0xFF2E6B37), // Emerald brand green
                                  Color(0xFF90E09F), // Light botanical shine
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFD4AF37,
                                  ).withValues(alpha: 0.35),
                                  blurRadius: 16,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Container(
                              width: 62.w,
                              height: 62.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark
                                    ? const Color(0xFF0D2513)
                                    : const Color(0xFF143B1B),
                              ),
                              child: ClipOval(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.contain,
                                    errorBuilder: (ctx, err, stack) => Icon(
                                      Icons.spa_rounded,
                                      color: const Color(0xFFE5C158),
                                      size: 32.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],

                      // Luxury Brand Category Chip
                      Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: isDark ? 0.12 : 0.18,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(
                              0xFFE5C158,
                            ).withValues(alpha: 0.5),
                            width: 0.9,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              color: const Color(0xFFE5C158),
                              size: 12.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "OGAGLOW • HERBAL LUXURY",
                              style: TextStyle(
                                color: const Color(
                                  0xFFF3E5AB,
                                ), // Light gold tint
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Screen Title
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 27.sp,
                              letterSpacing: -0.4,
                              height: 1.2,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                  color: Colors.black.withValues(
                                    alpha: isDark ? 0.7 : 0.4,
                                  ),
                                ),
                              ],
                            ),
                      ),

                      SizedBox(height: 6.h),

                      // Screen Subtitle
                      Text(
                        widget.subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(
                            0xFFE5F4E8,
                          ), // Crisp high contrast green tint
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          height: 1.35,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              offset: const Offset(0, 1),
                              color: Colors.black.withValues(
                                alpha: isDark ? 0.6 : 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
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
