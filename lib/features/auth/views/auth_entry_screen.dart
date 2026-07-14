import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/glow_background.dart';
import '../widgets/fade_slide_transition.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../app/routes/app_routes.dart';

class AuthEntryScreen extends StatelessWidget {
  const AuthEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlowBackground(
        child: SafeArea(
          top: false, // Let header draw under status bar
          child: Column(
            children: [
              /// Top Brand Header
              const AuthBrandHeader(
                title: 'OGA Glow',
                subtitle: 'Discover Your Natural Radiance',
              ),
              SizedBox(height: 24.h),

              /// Bottom Content
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      FadeSlideTransition(
                        index: 1,
                        child: Text(
                          "Welcome",
                          style: AppTextStyles.heading1.copyWith(
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      FadeSlideTransition(
                        index: 2,
                        child: Text(
                          "Discover natural beauty products carefully crafted for your skin and hair care journey.",
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 16.sp,
                            height: 1.6,
                          ),
                        ),
                      ),

                      const Spacer(),

                      FadeSlideTransition(
                        index: 3,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Continue",
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              PulsingCircleButton(
                                onTap: () {
                                  Get.toNamed(AppRoutes.login);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 48.h),
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

class PulsingCircleButton extends StatefulWidget {
  const PulsingCircleButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<PulsingCircleButton> createState() => _PulsingCircleButtonState();
}

class _PulsingCircleButtonState extends State<PulsingCircleButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Outer expanding aura
              Container(
                width: 52.w + _controller.value * 24.w,
                height: 52.h + _controller.value * 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(1.0 - _controller.value),
                ),
              ),
              // Inner solid button
              Container(
                width: 52.w,
                height: 52.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
