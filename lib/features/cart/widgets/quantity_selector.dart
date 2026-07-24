import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int minQuantity;
  final double height;
  final double iconSize;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.minQuantity = 1,
    this.height = 36,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = quantity > minQuantity;
    final colors = AppColors.of(context);

    return Container(
      height: height.h,
      decoration: BoxDecoration(
        color: colors.panelSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colors.border,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BounceTap(
            onTap: onDecrement,
            scaleBound: 0.85,
            child: Container(
              width: (height - 8).w,
              height: (height - 8).h,
              decoration: BoxDecoration(
                color: canDecrement
                    ? colors.cardBackground
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: canDecrement
                    ? [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Icon(
                Icons.remove_rounded,
                size: iconSize.sp,
                color: canDecrement
                    ? AppColors.primary
                    : Theme.of(context).disabledColor,
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 32.w),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: AppTextStyles.heading2.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
          ),
          BounceTap(
            onTap: onIncrement,
            scaleBound: 0.85,
            child: Container(
              width: (height - 8).w,
              height: (height - 8).h,
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.add_rounded,
                size: iconSize.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
