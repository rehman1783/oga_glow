import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_wave_clipper.dart';

class AuthBrandHeader extends StatefulWidget {
  const AuthBrandHeader({
    super.key,
    this.title = 'OGA Glow',
    this.subtitle = 'Welcome back! Please sign in.',
  });

  final String title;
  final String subtitle;

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
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeIn,
    );
    _entranceController.forward();

    // Infinite breathing animation for the background pattern
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ClipPath(
        clipper: AuthWaveClipper(),
        child: Container(
          height: 260.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6B8E23), Color(0xFFA8C686)],
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              // Breathing background brand pattern
              Positioned.fill(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Opacity(
                    opacity: 0.15,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Soft gradient overlay for text readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              // Main content
              Positioned(
                top: 48.h,
                left: 24.w,
                right: 24.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 28.sp,
                        shadows: const [
                          Shadow(
                            blurRadius: 8,
                            offset: Offset(0, 3),
                            color: Color(0x40000000),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.w500,
                        shadows: const [
                          Shadow(
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            color: Color(0x30000000),
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
