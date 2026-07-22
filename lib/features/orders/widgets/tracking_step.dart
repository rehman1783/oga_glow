import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/order_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A single step in the order tracking timeline.
///
/// Shows an icon (check/circle), title, date/time, and description.
/// Completed steps are highlighted with the primary color;
/// future steps are shown in muted/grey tones.
class TrackingStep extends StatelessWidget {
  final TrackingStepModel step;
  final bool isLast;

  const TrackingStep({
    super.key,
    required this.step,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + connecting line column
          SizedBox(
            width: 32.w,
            child: Column(
              children: [
                // Icon
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: step.isCompleted
                        ? AppColors.primary
                        : isDark
                            ? AppColors.panelDark
                            : AppColors.borderLight.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: step.isCompleted
                          ? AppColors.primary
                          : isDark
                              ? AppColors.borderDark
                              : AppColors.borderLight,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    step.isCompleted
                        ? Icons.check_rounded
                        : Icons.circle_rounded,
                    size: step.isCompleted ? 14.sp : 8.sp,
                    color: step.isCompleted
                        ? Colors.white
                        : isDark
                            ? AppColors.mutedDark
                            : AppColors.mutedLight,
                  ),
                ),
                // Connecting line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.w,
                      color: step.isCompleted
                          ? AppColors.primary.withOpacity(0.4)
                          : isDark
                              ? AppColors.borderDark.withOpacity(0.3)
                              : AppColors.borderLight.withOpacity(0.3),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    step.title,
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: 14.sp,
                      fontWeight:
                          step.isCompleted ? FontWeight.w700 : FontWeight.w500,
                      color: step.isCompleted
                          ? Theme.of(context).colorScheme.onSurface
                          : isDark
                              ? AppColors.mutedDark
                              : AppColors.mutedLight,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Date & Time
                  if (step.dateTime.isNotEmpty)
                    Text(
                      step.dateTime,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        color: step.isCompleted
                            ? AppColors.primary
                            : isDark
                                ? AppColors.mutedDark
                                : AppColors.mutedLight,
                      ),
                    ),
                  SizedBox(height: 4.h),

                  // Description
                  Text(
                    step.description,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11.sp,
                      color: isDark
                          ? AppColors.mutedDark.withOpacity(0.8)
                          : AppColors.mutedLight.withOpacity(0.8),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

