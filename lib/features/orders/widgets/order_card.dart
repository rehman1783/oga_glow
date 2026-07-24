import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/order_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/bounce_tap.dart';
import 'order_status_chip.dart';

/// A premium card displaying an order in the order history list.
///
/// Shows product image, name, order ID, quantity, total, date,
/// payment method, status chip, and a "View Details" button.
class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onViewDetails;

  const OrderCard({
    super.key,
    required this.order,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
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
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Top Row: Image + Info ----
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image placeholder
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.shopping_bag_rounded,
                      size: 28.sp,
                      color: AppColors.primary.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name
                      Text(
                        order.productName,
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.of(context).textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),

                      // Order ID
                      Text(
                        'Order: ${order.orderId}',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 11.sp,
                          color: AppColors.of(context).textSecondary,
                        ),
                      ),
                      SizedBox(height: 2.h),

                      // Quantity + Total
                      Row(
                        children: [
                          Text(
                            'Qty: ${order.quantity}',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.sp,
                              color: AppColors.of(context).textSecondary,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                            style: AppTextStyles.body.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(
              height: 1,
              color: AppColors.of(context).border,
            ),

            // ---- Bottom Row: Date, Payment, Status ----
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: [
                  // Date
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 12.sp,
                    color: AppColors.of(context).textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    order.orderDate,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.of(context).textSecondary,
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Payment method
                  Icon(
                    Icons.payment_rounded,
                    size: 12.sp,
                    color: AppColors.of(context).textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      order.paymentMethod,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.of(context).textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Status chip
                  OrderStatusChip(status: order.status),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: AppColors.of(context).border,
            ),

            // ---- View Details Button ----
            SizedBox(height: 8.h),
            BounceTap(
              onTap: onViewDetails,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.visibility_rounded,
                      size: 16.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'View Details',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

