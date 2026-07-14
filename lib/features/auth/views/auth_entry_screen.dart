import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/auth/widgets/auth_brand_header.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../app/routes/app_routes.dart';

class AuthEntryScreen extends StatelessWidget {
  const AuthEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.bannerGradientStart, AppColors.bannerGradientEnd],
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// Top Section
            SizedBox(height: 12),
            AuthBrandHeader(),
            SizedBox(height: 18),

            /// Bottom Content
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    Text(
                      "Welcome",
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 38.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 14.h),

                    Text(
                      "Discover natural beauty products carefully crafted for your skin and hair care journey.",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    const Spacer(),

                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.login);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Continue",
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),

                            SizedBox(width: 12.w),

                            Container(
                              width: 52.w,
                              height: 52.h,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
