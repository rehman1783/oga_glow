import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A premium search bar for filtering orders by Order ID or Product Name.
///
/// Fully theme-aware and responsive using [flutter_screenutil].
class OrderSearchBar extends StatelessWidget {
  /// Callback invoked on every text change with the current query.
  final ValueChanged<String> onChanged;

  /// Optional controller for managing the text field from outside.
  final TextEditingController? controller;

  const OrderSearchBar({
    super.key,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.of(context).border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.body.copyWith(
          fontSize: 14.sp,
          color: AppColors.of(context).textPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'Search by Order ID or Product Name...',
          hintStyle: AppTextStyles.body.copyWith(
            fontSize: 14.sp,
            color: AppColors.of(context).textSecondary,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 22.sp,
            color: AppColors.of(context).textSecondary,
          ),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: AppColors.of(context).textSecondary,
                  ),
                  onPressed: () {
                    controller?.clear();
                    onChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

