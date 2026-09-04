import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return BounceTap(
      scaleBound: 0.92,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? AppColors.luxuryGradient
              : null,
          color: isSelected ? null : colors.cardBackground,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryLight
                : colors.border.withValues(alpha: 0.8),
            width: isSelected ? 1.4 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.28),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.caption.copyWith(
            color: isSelected ? Colors.white : colors.textPrimary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            fontSize: 12.5.sp,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}
