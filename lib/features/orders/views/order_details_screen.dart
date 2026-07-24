import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/order_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import '../widgets/order_status_chip.dart';
import '../widgets/order_timeline.dart';
import '../widgets/order_summary_card.dart';

/// Order Details screen.
///
/// Displays full order information, shipping details, and a real-time
/// tracking timeline. Receives the [OrderModel] via [Get.arguments].
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as OrderModel;
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
          'Order Details',
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            color: AppColors.of(context).textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Product Info Header ----
              FadeSlideTransition(
                index: 0,
                child: _buildProductHeader(order, isDark),
              ),
              SizedBox(height: 20.h),

              // ---- Order Summary ----
              FadeSlideTransition(
                index: 1,
                child: _buildSectionTitle('Order Summary', Icons.receipt_rounded),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 2,
                child: _buildOrderSummaryCard(order, isDark),
              ),
              SizedBox(height: 20.h),

              // ---- Shipping Info ----
              FadeSlideTransition(
                index: 3,
                child: _buildSectionTitle('Shipping Information', Icons.local_shipping_rounded),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 4,
                child: Column(
                  children: [
                    OrderSummaryCard(
                      icon: Icons.person_rounded,
                      label: 'Customer Name',
                      value: order.customerName,
                    ),
                    SizedBox(height: 10.h),
                    OrderSummaryCard(
                      icon: Icons.phone_rounded,
                      label: 'Phone Number',
                      value: order.phoneNumber,
                    ),
                    SizedBox(height: 10.h),
                    OrderSummaryCard(
                      icon: Icons.location_on_rounded,
                      label: 'Shipping Address',
                      value: order.shippingAddress,
                    ),
                    SizedBox(height: 10.h),
                    OrderSummaryCard(
                      icon: Icons.calendar_today_rounded,
                      label: 'Estimated Delivery',
                      value: order.estimatedDelivery,
                    ),
                    if (order.notes.isNotEmpty) ...[
                      SizedBox(height: 10.h),
                      OrderSummaryCard(
                        icon: Icons.notes_rounded,
                        label: 'Order Notes',
                        value: order.notes,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // ---- Order Tracking ----
              FadeSlideTransition(
                index: 5,
                child: _buildSectionTitle('Order Tracking', Icons.timeline_rounded),
              ),
              SizedBox(height: 8.h),
              FadeSlideTransition(
                index: 6,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).cardBackground,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: AppColors.of(context).border,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: OrderTimeline(steps: order.trackingSteps),
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the product header section with image, name, order ID and status.
  Widget _buildProductHeader(OrderModel order, bool isDark) {
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.of(context).cardBackground,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: AppColors.of(context).border,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Product image placeholder
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    size: 32.sp,
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
              ),
              SizedBox(width: 14.w),

              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.productName,
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.of(context).textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Order: ${order.orderId}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.of(context).textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    OrderStatusChip(status: order.status),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the order summary card with quantity, unit price, total etc.
  Widget _buildOrderSummaryCard(OrderModel order, bool isDark) {
    return Builder(
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.of(context).cardBackground,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: AppColors.of(context).border,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _summaryRow(context, 'Quantity', '${order.quantity}'),
              Divider(height: 20, color: AppColors.of(context).border),
              _summaryRow(
                context,
                'Unit Price',
                '\$${order.unitPrice.toStringAsFixed(2)}',
              ),
              Divider(height: 20, color: AppColors.of(context).border),
              _summaryRow(context, 'Payment Method', order.paymentMethod),
              Divider(height: 20, color: AppColors.of(context).border),
              _summaryRow(context, 'Order Date', order.orderDate),
              Divider(height: 20, color: AppColors.of(context).border),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  Text(
                    '\$${order.totalPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 13.sp,
            color: AppColors.of(context).textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.body.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.of(context).textPrimary,
          ),
        ),
      ],
    );
  }

  /// Builds a section title with an accent bar and icon.
  Widget _buildSectionTitle(String title, IconData icon) {
    return Builder(
      builder: (context) {
        return Row(
          children: [
            Container(
              width: 4.w,
              height: 22.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 10.w),
            Icon(
              icon,
              size: 20.sp,
              color: AppColors.primary,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.of(context).textPrimary,
              ),
            ),
          ],
        );
      },
    );
  }
}

