import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../../core/widgets/fade_slide_transition.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/order_coupon_section.dart';
import '../widgets/section_title.dart';
import '../widgets/shipping_address_form.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Checkout',
          style: AppTextStyles.heading2.copyWith(
            fontSize: 18.sp,
            color: colors.textPrimary,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Animated Step Tracker
                      FadeSlideTransition(
                        index: 0,
                        child: _buildStepProgressTracker(context),
                      ),

                      SizedBox(height: 18.h),

                      // Section 0: Order Items Summary
                      FadeSlideTransition(
                        index: 1,
                        child: _buildItemsSummary(context),
                      ),


                      SizedBox(height: 20.h),

                      // Section 1: Contact & Address Form Card
                      FadeSlideTransition(
                        index: 1,
                        child: const ShippingAddressForm(),
                      ),

                      SizedBox(height: 20.h),

                      // Section 2: Promo & Coupon Code
                      FadeSlideTransition(
                        index: 2,
                        child: const OrderCouponSection(),
                      ),

                      SizedBox(height: 20.h),

                      // Section 3: Payment Method
                      FadeSlideTransition(
                        index: 3,
                        child: _buildPaymentMethodSection(context),
                      ),

                      SizedBox(height: 20.h),

                      // Section 4: Live Price Breakdown Preview
                      FadeSlideTransition(
                        index: 4,
                        child: _buildPriceBreakdownCard(context),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Place Order CTA
              FadeSlideTransition(
                index: 5,
                child: _buildBottomCTA(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemsSummary(BuildContext context) {
    final colors = AppColors.of(context);

    return Obx(() {
      final items = controller.cartItems;
      if (items.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: 'Order Items'),
              Text(
                '${items.length} ${items.length == 1 ? 'item' : 'items'}',
                style: AppTextStyles.caption.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: colors.border),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (ctx, i) => Divider(height: 16.h, color: colors.border),
              itemBuilder: (context, index) {
                final item = items[index];
                final name = item['name']?.toString() ?? 'Product';
                final img = item['image']?.toString() ?? '';
                final qty = item['quantity'] ?? 1;
                final price = item['price']?.toString() ?? '0';

                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        color: colors.panelSecondary,
                        child: img.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: img,
                                fit: BoxFit.cover,
                                placeholder: (ctx, url) => Shimmer.fromColors(
                                  baseColor: colors.panelSecondary,
                                  highlightColor: colors.cardBackground,
                                  child: Container(color: colors.panelSecondary),
                                ),
                                errorWidget: (ctx, url, error) => Icon(
                                  Icons.spa_rounded,
                                  color: AppColors.primary.withValues(alpha: 0.5),
                                  size: 24.sp,
                                ),
                              )
                            : Icon(
                                Icons.spa_rounded,

                                color: AppColors.primary.withValues(alpha: 0.5),
                                size: 24.sp,
                              ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Qty: $qty',
                            style: AppTextStyles.caption.copyWith(
                              color: colors.textSecondary,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Rs. $price',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPaymentMethodSection(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Payment & Delivery'),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // COD Payment Tile
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.panelSecondary,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.payments_rounded,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cash on Delivery (COD)',
                            style: AppTextStyles.heading2.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Pay cash at your doorstep upon receiving order',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.sp,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Leopards Courier notice
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      color: AppColors.primary,
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Fast courier booking via Leopards Courier with real-time tracking.',
                        style: AppTextStyles.caption.copyWith(
                          color: colors.textPrimary,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBreakdownCard(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitle(title: 'Price Details'),
            Obx(() {
              if (controller.isLoadingPreview.value) {
                return Row(
                  children: [
                    SizedBox(
                      width: 12.w,
                      height: 12.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Calculating...',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: colors.border),
          ),
          child: Obx(() {
            final subtotal = controller.subtotal;
            final productDiscount = controller.productDiscount;
            final couponDiscount = controller.couponDiscount;
            final shipping = controller.shipping;
            final grandTotal = controller.grandTotal;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Items Price',
                      style: AppTextStyles.caption.copyWith(
                        color: colors.textSecondary,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      'Rs. ${subtotal.toStringAsFixed(0)}',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),

                if (productDiscount > 0) ...[
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Discount',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        '- Rs. ${productDiscount.toStringAsFixed(0)}',
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ],

                if (couponDiscount > 0) ...[
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Coupon Discount',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        '- Rs. ${couponDiscount.toStringAsFixed(0)}',
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping Fee',
                      style: AppTextStyles.caption.copyWith(
                        color: colors.textSecondary,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      shipping > 0
                          ? 'Rs. ${shipping.toStringAsFixed(0)}'
                          : 'Free Delivery',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: shipping > 0 ? colors.textPrimary : AppColors.success,
                      ),
                    ),
                  ],
                ),

                Divider(height: 20.h, color: colors.border),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 15.sp,
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      'Rs. ${grandTotal.toStringAsFixed(0)}',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grand Total (COD)',
                      style: AppTextStyles.caption.copyWith(
                        color: colors.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),
                    Obx(
                      () => Text(
                        'Rs. ${controller.grandTotal.toStringAsFixed(0)}',
                        style: AppTextStyles.heading2.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: SizedBox(
                      height: 50.h,
                      child: Obx(() {
                        final isBusy = controller.isPlacingOrder.value;

                        return BounceTap(
                          onTap: isBusy ? () {} : () => controller.placeOrder(context),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.primaryLight,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.28),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: isBusy
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 18.w,
                                        height: 18.w,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Placing Order...',
                                        style: AppTextStyles.button.copyWith(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: AppColors.white,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Place Order',
                                        style: AppTextStyles.button.copyWith(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepProgressTracker(BuildContext context) {
    final colors = AppColors.of(context);

    Widget stepNode({
      required String number,
      required String label,
      required bool isCompleted,
      required bool isActive,
    }) {
      return Column(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              gradient: (isCompleted || isActive)
                  ? const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                    )
                  : null,
              color: (isCompleted || isActive) ? null : colors.panelSecondary,
              shape: BoxShape.circle,
              border: Border.all(
                color: (isCompleted || isActive)
                    ? AppColors.primary
                    : colors.border,
                width: 1.2,
              ),
              boxShadow: (isCompleted || isActive)
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: isCompleted
                ? Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 16.sp,
                  )
                : Text(
                    number,
                    style: TextStyle(
                      color: isActive ? Colors.white : colors.textSecondary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: (isCompleted || isActive)
                  ? colors.textPrimary
                  : colors.textSecondary,
              fontSize: 10.sp,
              fontWeight:
                  (isCompleted || isActive) ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      );
    }

    Widget stepDivider({required bool isPassed}) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 18.h),
          height: 2.h,
          decoration: BoxDecoration(
            color: isPassed
                ? AppColors.primary
                : colors.border.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          stepNode(number: '1', label: 'Cart', isCompleted: true, isActive: false),
          stepDivider(isPassed: true),
          stepNode(number: '2', label: 'Address', isCompleted: false, isActive: true),
          stepDivider(isPassed: false),
          stepNode(number: '3', label: 'Payment', isCompleted: false, isActive: false),
        ],
      ),
    );
  }
}

