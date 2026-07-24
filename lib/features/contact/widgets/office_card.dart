import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Displays an office location card for the Contact Us screen.
///
/// Shows the office [title], [city], and [address] with a location icon.
class OfficeCard extends StatelessWidget {
  /// Office type label (e.g., "Head Office", "Sub Office").
  final String title;

  /// City name (e.g., "Karachi", "Hyderabad").
  final String city;

  /// Full address line (e.g., "Sharah-e-Faisal, Sindh").
  final String address;

  const OfficeCard({
    super.key,
    required this.title,
    required this.city,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).panelSecondary,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location icon
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_on_rounded,
              size: 22.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 14.w),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  city,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  address,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
