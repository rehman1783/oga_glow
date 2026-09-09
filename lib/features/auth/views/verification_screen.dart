import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../widgets/auth_brand_header.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/fade_slide_transition.dart';
import '../widgets/glow_background.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;

  int _resendCooldown = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _startCooldownTimer();
  }

  void _startCooldownTimer() {
    setState(() {
      _resendCooldown = 60;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _openEmailApp() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
    );
    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        CustomSnackbar.showInfo(
          title: 'Email App',
          message: 'Please open your email app manually to check your inbox.',
        );
      }
    } catch (_) {
      CustomSnackbar.showInfo(
        title: 'Email App',
        message: 'Please check your mail app to verify your account.',
      );
    }
  }

  void _resendVerification() {
    if (!_canResend) return;
    _startCooldownTimer();
    CustomSnackbar.showSuccess(
      title: 'Verification Link Sent',
      message: 'A new verification link has been sent to your email.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentGreen = isDark ? AppColors.primaryLight : AppColors.primary;

    final String userEmail = (Get.arguments is String)
        ? Get.arguments as String
        : 'your email address';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlowBackground(
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthBrandHeader(
                  title: 'Verify Your Email',
                  subtitle: 'Check your inbox to complete registration.',
                  showBackButton: true,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 12.h),

                      // Pulsing Email Badge
                      FadeSlideTransition(
                        index: 1,
                        child: Center(
                          child: ScaleTransition(
                            scale: _pulseScale,
                            child: Container(
                              width: 96.w,
                              height: 96.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark ? const Color(0xFF122C1A) : AppColors.primary.withValues(alpha: 0.12),
                                border: Border.all(
                                  color: isDark ? accentGreen.withValues(alpha: 0.6) : AppColors.primary.withValues(alpha: 0.35),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentGreen.withValues(alpha: isDark ? 0.3 : 0.2),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.mark_email_read_rounded,
                                size: 50,
                                color: accentGreen,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 22.h),

                      FadeSlideTransition(
                        index: 2,
                        child: Text(
                          'Verification Link Sent!',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Email highlight chip
                      FadeSlideTransition(
                        index: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF102015) : colors.panel,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isDark ? const Color(0xFF22422A) : colors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.email_outlined, size: 16, color: accentGreen),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  userEmail,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 14.h),

                      FadeSlideTransition(
                        index: 4,
                        child: Text(
                          'We sent an activation link to your inbox. Tap the link in your email to verify your account, then return to sign in.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark ? const Color(0xFF9EBEA5) : colors.textSecondary,
                            height: 1.5,
                            fontSize: 13.5.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // Action Buttons
                      FadeSlideTransition(
                        index: 5,
                        child: Column(
                          children: [
                            // Open Email App Button
                            SizedBox(
                              width: double.infinity,
                              height: 48.h,
                              child: OutlinedButton.icon(
                                onPressed: _openEmailApp,
                                icon: const Icon(Icons.open_in_new_rounded, size: 18),
                                label: const Text('Open Email App'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: accentGreen,
                                  backgroundColor: isDark ? const Color(0xFF102015) : Colors.transparent,
                                  side: BorderSide(color: accentGreen, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 12.h),

                            // I Have Verified Button
                            AuthSubmitButton(
                              text: 'I Have Verified My Email',
                              isLoading: false,
                              onPressed: () {
                                Get.offAllNamed(AppRoutes.login);
                              },
                            ),

                            SizedBox(height: 16.h),

                            // Resend Email with countdown
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't receive email? ",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDark ? const Color(0xFF8BAE92) : colors.textSecondary,
                                  ),
                                ),
                                TextButton(
                                  onPressed: _canResend ? _resendVerification : null,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    _canResend
                                        ? 'Resend Link'
                                        : 'Resend in ${_resendCooldown}s',
                                    style: TextStyle(
                                      color: _canResend ? accentGreen : (isDark ? const Color(0xFF54745C) : Colors.grey),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.5.sp,
                                    ),
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
