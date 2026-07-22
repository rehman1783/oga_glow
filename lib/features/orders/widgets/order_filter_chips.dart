import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/order_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A horizontal scrollable row of filter chips for order statuses.
///
/// Supports "All", "Processing", "Shipped", "Out for Delivery",
/// "Delivered", and "Cancelled".
class OrderFilterChips extends StatelessWidget {
  /// Currently selected status. Null means "All".
  final OrderStatus? selectedStatus;

  /// Callback when a chip is tapped. Null is passed for "All".
  final ValueChanged<OrderStatus?> onStatusChanged;

  const OrderFilterChips({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Define filter options
    final filters = <_FilterOption>[
      _FilterOption(label: 'All', status: null),
      _FilterOption(label: OrderStatus.processing.label, status: OrderStatus.processing),
      _FilterOption(label: OrderStatus.shipped.label, status: OrderStatus.shipped),
      _FilterOption(label: 'Out for Delivery', status: OrderStatus.outForDelivery),
      _FilterOption(label: OrderStatus.delivered.label, status: OrderStatus.delivered),
      _FilterOption(label: OrderStatus.cancelled.label, status: OrderStatus.cancelled),
    ];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedStatus == filter.status;

          return GestureDetector(
            onTap: () => onStatusChanged(filter.status),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : isDark
                        ? AppColors.panelDark
                        : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : isDark
                          ? AppColors.borderDark.withOpacity(0.5)
                          : AppColors.borderLight.withOpacity(0.5),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  filter.label,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : isDark
                            ? AppColors.textDark.withOpacity(0.8)
                            : AppColors.textLight.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterOption {
  final String label;
  final OrderStatus? status;

  const _FilterOption({required this.label, required this.status});
}

