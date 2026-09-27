import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer skeleton loading placeholder for About Us page.
class AboutShimmerLoading extends StatelessWidget {
  const AboutShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Hero Banner Placeholder
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            SizedBox(height: 18.h),

            // Highlight Cards Placeholder (3 cards)
            ...List.generate(
              3,
              (index) => Container(
                height: 58.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // CTA Buttons Placeholder
            Container(
              height: 115.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            SizedBox(height: 20.h),

            // Single Body Image Placeholder (Total 2 image placeholders: 1 Header + 1 Body)
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            SizedBox(height: 16.h),

            // FAQ Items Placeholder
            ...List.generate(
              3,
              (index) => Container(
                height: 54.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
