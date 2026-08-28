import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/order_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/bounce_tap.dart';
import 'order_status_chip.dart';

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
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.8),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 14,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                    width: 72.w,
                    height: 72.w,
                    child: order.productImage.startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl: order.productImage,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              color: colors.panelSecondary,
                              child: Icon(
                                Icons.spa_rounded,
                                color: AppColors.primary.withValues(alpha: 0.4),
                                size: 28.sp,
                              ),
                            ),
                          )
                        : (order.productImage.startsWith('assets/')
                            ? Image.asset(
                                order.productImage,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  color: colors.panelSecondary,
                                  child: Icon(
                                    Icons.spa_rounded,
                                    color: AppColors.primary.withValues(alpha: 0.4),
                                    size: 28.sp,
                                  ),
                                ),
                              )
                            : Container(
                                color: colors.panelSecondary,
                                child: Icon(
                                  Icons.shopping_bag_rounded,
                                  color: AppColors.primary.withValues(alpha: 0.5),
                                  size: 28.sp,
                                ),
                              )),
                  ),
                ),
                SizedBox(width: 12.w),

                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              order.productName,
                              style: AppTextStyles.heading2.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          OrderStatusChip(status: order.status),
                        ],
                      ),
                      SizedBox(height: 4.h),

                      Text(
                        'ID: ${order.orderId}',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 11.sp,
                          color: colors.textSecondary,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 4.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Qty: ${order.quantity}',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.5.sp,
                              color: colors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Rs. ${order.totalPrice.toStringAsFixed(0)}',
                            style: AppTextStyles.heading2.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
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

            if (order.trackingNumber.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${order.courierName.isNotEmpty ? order.courierName : "Leopards"}: ${order.trackingNumber}',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 10.5.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 10.h),
            Divider(height: 1, color: colors.border),

            // ---- Bottom Row: Date, Payment, Action ----
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        order.orderDate,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 11.sp,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  BounceTap(
                    scaleBound: 0.92,
                    onTap: onViewDetails,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.visibility_outlined,
                            size: 13,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Details',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
