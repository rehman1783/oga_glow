import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
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
/// Displays real user orders fetched directly from the backend API
/// with search and status filtering capability and pull-to-refresh.
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
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.refreshOrders,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- Welcome Header ----
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: FadeSlideTransition(
                    index: 0,
                    child: _buildWelcomeHeader(isDark, context),
                  ),
                ),
                SizedBox(height: 16.h),

                // ---- Introduction ----
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: FadeSlideTransition(
                    index: 1,
                    child: Text(
                      'View and track your real orders in real-time. '
                      'Search by Order ID or filter by status.',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.of(context).textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // ---- Search Bar ----
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: FadeSlideTransition(
                    index: 2,
                    child: OrderSearchBar(
                      onChanged: (query) => controller.searchOrders(query),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),

                // ---- Filter Chips (Edge-to-Edge Scrollable) ----
                FadeSlideTransition(
                  index: 3,
                  child: Obx(
                    () => OrderFilterChips(
                      selectedStatus: controller.selectedStatus.value,
                      onStatusChanged: (status) =>
                          controller.filterByStatus(status),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // ---- Reactive Content Area ----
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Obx(() {
                    // 1. Loading State
                    if (controller.isLoading.value &&
                        controller.allOrders.isEmpty) {
                      return _buildLoadingState(context);
                    }

                    // 2. Unauthorized / Guest State
                    if (controller.isUnauthorized.value &&
                        controller.allOrders.isEmpty) {
                      return _buildSignInPrompt(context);
                    }

                    // 3. Error State
                    if (controller.errorMessage.value.isNotEmpty &&
                        controller.allOrders.isEmpty) {
                      return _buildErrorState(context);
                    }

                    // 4. Empty State
                    final orders = controller.filteredOrders;
                    if (orders.isEmpty) {
                      return const EmptyOrdersWidget();
                    }

                    // 5. Orders List
                    return FadeSlideTransition(
                      index: 4,
                      child: Column(
                        children: [
                          // Results count
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${orders.length} ${orders.length == 1 ? 'Order' : 'Orders'}',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.of(context).textSecondary,
                                ),
                              ),
                              if (controller.isLoading.value)
                                SizedBox(
                                  width: 14.w,
                                  height: 14.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
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
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the welcome header with an icon and title.
  Widget _buildWelcomeHeader(bool isDark, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.primaryLight.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
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
                  blurRadius: 14,
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
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Live tracking & real purchase history',
                  style: AppTextStyles.body.copyWith(
                    fontSize: 12.5.sp,
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

  /// Loading placeholder cards.
  Widget _buildLoadingState(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        SizedBox(height: 16.h),
        Text(
          'Fetching your orders from server...',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.of(context).textSecondary,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }

  /// Sign In Required prompt when user is not logged in.
  Widget _buildSignInPrompt(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).panel,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              size: 30.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Sign In to View Orders',
            style: AppTextStyles.heading2.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.of(context).textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Please log in with your OGAGLOW account to view your purchase history and track active orders.',
            style: AppTextStyles.body.copyWith(
              fontSize: 13.sp,
              color: AppColors.of(context).textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.login),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Sign In Now',
                style: AppTextStyles.button.copyWith(fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Error state with retry button.
  Widget _buildErrorState(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).panel,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: Column(
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 40.sp,
            color: AppColors.error.withValues(alpha: 0.7),
          ),
          SizedBox(height: 14.h),
          Text(
            'Unable to Load Orders',
            style: AppTextStyles.heading2.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.of(context).textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            controller.errorMessage.value,
            style: AppTextStyles.body.copyWith(
              fontSize: 12.5.sp,
              color: AppColors.of(context).textSecondary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18.h),
          OutlinedButton.icon(
            onPressed: () => controller.fetchOrders(),
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Try Again'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
