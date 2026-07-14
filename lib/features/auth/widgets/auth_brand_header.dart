import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBrandHeader extends StatefulWidget {
  const AuthBrandHeader({super.key});

  @override
  State<AuthBrandHeader> createState() => _AuthBrandHeaderState();
}

class _AuthBrandHeaderState extends State<AuthBrandHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Container(
        height: 280.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6B8E23), Color(0xFFA8C686)],
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.18,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 28.h,
              left: 20.w,
              right: 20.w,
              child: Text(
                'OGA Glow',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      blurRadius: 12,
                      offset: Offset(0, 6),
                      color: Color(0x33000000),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 22.h,
              left: 20.w,
              right: 20.w,
              child: Text(
                'Welcome back! Please sign in.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
