import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/bounce_tap.dart';

/// A single tappable contact row used in the Contact Us screen.
///
/// Displays an [icon], a [label], and a [value].
/// The entire row is tappable; provide an [onTap] callback to handle the action.
class ContactRow extends StatelessWidget {
  /// Leading icon for the row.
  final IconData icon;

  /// Title / label text (e.g., "Email", "OgaGlow").
  final String label;

  /// Value / detail text (e.g., the actual email address or phone number).
  final String value;

  /// Callback when the row is tapped.
  final VoidCallback? onTap;

  const ContactRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, size: 20.sp, color: AppColors.primary),
            ),
            SizedBox(width: 14.w),
            // Label and value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.of(context).textSecondary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    value,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            // Chevron
            Icon(
              Icons.chevron_right_rounded,
              size: 22.sp,
              color: AppColors.of(context).textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
