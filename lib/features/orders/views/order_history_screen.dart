import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../controllers/order_controller.dart';
import '../widgets/order_card.dart';
import '../widgets/order_filter_chips.dart';
import '../widgets/order_search_bar.dart';
import '../widgets/empty_orders_widget.dart';

/// Order History Screen.
///
/// Displays a list of user orders with search and filter capability.
/// Fully responsive, theme-aware, and follows the OgaGlow design system.
class OrderHistoryScreen extends GetView<OrderController> {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          'My Orders',
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            color: AppColors.of(context).textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ---- Scrollable Content ----
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---- Welcome Header ----
                    FadeSlideTransition(
                      index: 0,
                      child: _buildWelcomeHeader(isDark),
                    ),
                    SizedBox(height: 16.h),

                    // ---- Introduction ----
                    FadeSlideTransition(
                      index: 1,
                      child: Text(
                        'View and track all your orders in one place. '
                        'Use the search bar or filters to find specific orders.',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.of(context).textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ---- Search Bar ----
                    FadeSlideTransition(
                      index: 2,
                      child: OrderSearchBar(
                        onChanged: (query) => controller.searchOrders(query),
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // ---- Filter Chips ----
                    FadeSlideTransition(
                      index: 3,
                      child: Obx(
                        () => OrderFilterChips(
                          selectedStatus: controller.selectedStatus.value,
                          onStatusChanged:
                              (status) => controller.filterByStatus(status),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // ---- Orders List / Empty State ----
                    Obx(() {
                      final orders = controller.filteredOrders;

                      if (orders.isEmpty) {
                        return const EmptyOrdersWidget();
                      }

                      return FadeSlideTransition(
                        index: 4,
                        child: Column(
                          children: [
                            // Results count
                            Row(
                              children: [
                                Text(
                                  '${orders.length} ${orders.length == 1 ? 'Order' : 'Orders'}',
                                  style: AppTextStyles.caption.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.of(context).textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            // Order cards
                            for (int i = 0; i < orders.length; i++)
                              FadeSlideTransition(
                                index: i + 5,
                                child: OrderCard(
                                  order: orders[i],
                                  onViewDetails: () =>
                                      controller.openOrderDetails(orders[i]),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the welcome header with an icon and title.
  Widget _buildWelcomeHeader(bool isDark) {
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.12),
                AppColors.primaryLight.withValues(alpha: 0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.of(context).cardBackground,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  size: 22.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Orders',
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Track, manage & review your purchases',
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
      },
    );
  }
}

