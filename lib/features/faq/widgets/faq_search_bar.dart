import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/constants/faq_constants.dart';
import 'package:oga_glow/features/faq/controllers/faq_controller.dart';

/// A premium search bar for filtering FAQ items.
///
/// Calls [onChanged] whenever the user types, with the current query.
/// Fully theme-aware and responsive using [flutter_screenutil].
class FAQSearchBar extends StatelessWidget {
  /// Callback invoked on every text change with the current query.
  final ValueChanged<String> onChanged;

  /// Optional controller for managing the text field from outside.
  final TextEditingController? controller;

  const FAQSearchBar({
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
          hintText: FaqConstants.searchHint,
          hintStyle: AppTextStyles.body.copyWith(
            fontSize: 14.sp,
            color: AppColors.of(context).textSecondary,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 22.sp,
            color: AppColors.of(context).textSecondary,
          ),
          suffixIcon: Obx(
            () {
              // Show clear button only when there's text
              final controller = Get.find<FaqController>();
              if (controller.searchQuery.value.isNotEmpty) {
                return IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: AppColors.of(context).textSecondary,
                  ),
                  onPressed: () {
                    controller.filterFAQs('');
                    // Also clear the local text controller if provided
                    this.controller?.clear();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
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

