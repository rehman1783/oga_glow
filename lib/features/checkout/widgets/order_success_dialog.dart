import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../main_navigation/controllers/main_navigation_controller.dart';
import '../models/place_order_model.dart';

class OrderSuccessDialog extends StatelessWidget {
  final OrderData order;

  const OrderSuccessDialog({
    super.key,
    required this.order,
  });

  static Future<void> show(BuildContext context, OrderData order) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => OrderSuccessDialog(order: order),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tracking = order.trackingNumber ?? 'Pending Booking';
    final courier = order.courierName ?? 'Leopards Courier';

    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Container(
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(color: colors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Success Icon
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.success, Color(0xFF10B981)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success.withValues(alpha: 0.3),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 38.sp,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  'Order Confirmed!',
                  style: AppTextStyles.heading1.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  'Thank you for your order! We have received your request and booked shipping.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 12.sp,
                    color: colors.textSecondary,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 20.h),

                // Order & Tracking Info Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colors.panelSecondary,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: colors.border),
                  ),
                  child: Column(
                    children: [
                      // Order ID Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID',
                            style: AppTextStyles.caption.copyWith(
                              color: colors.textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                order.id.length > 10
                                    ? '#${order.id.substring(order.id.length - 8).toUpperCase()}'
                                    : '#${order.id}',
                                style: AppTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
                                  color: colors.textPrimary,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: order.id));
                                  CustomSnackbar.showInfo(
                                    title: 'Copied',
                                    message: 'Order ID copied to clipboard',
                                  );
                                },
                                child: Icon(
                                  Icons.copy_rounded,
                                  size: 14.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Divider(height: 20.h, color: colors.border),

                      // Tracking Number Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_shipping_rounded,
                                size: 16.sp,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                courier,
                                style: AppTextStyles.caption.copyWith(
                                  color: colors.textSecondary,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  tracking,
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              if (order.trackingNumber != null &&
                                  order.trackingNumber!.isNotEmpty) ...[
                                SizedBox(width: 4.w),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(
                                      ClipboardData(text: order.trackingNumber!),
                                    );
                                    CustomSnackbar.showInfo(
                                      title: 'Copied',
                                      message: 'Tracking number copied to clipboard',
                                    );
                                  },
                                  child: Icon(
                                    Icons.copy_rounded,
                                    size: 14.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),

                      Divider(height: 20.h, color: colors.border),

                      // Payment Method & Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Method',
                            style: AppTextStyles.caption.copyWith(
                              color: colors.textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            order.paymentMethod == 'COD'
                                ? 'Cash on Delivery'
                                : order.paymentMethod,
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: AppTextStyles.heading2.copyWith(
                              fontSize: 13.sp,
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            'Rs. ${order.totalPrice.toStringAsFixed(0)}',
                            style: AppTextStyles.heading2.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Primary CTA: View in My Orders
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: BounceTap(
                    onTap: () {
                      Get.back(); // close dialog
                      Get.offNamed(AppRoutes.orderHistory);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'View Order in My Orders',
                        style: AppTextStyles.button.copyWith(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                // Secondary CTA: Continue Shopping
                SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: BounceTap(
                    onTap: () {
                      Get.back(); // close dialog
                      if (Get.isRegistered<MainNavigationController>()) {
                        Get.find<MainNavigationController>().changeIndex(0);
                        Get.until((route) =>
                            route.settings.name == AppRoutes.mainNavigation ||
                            route.isFirst);
                      } else {
                        Get.offAllNamed(AppRoutes.mainNavigation);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.panelSecondary,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: colors.border),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Continue Shopping',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
