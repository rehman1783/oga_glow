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
            Row(
              children: [
                Icon(
                  Icons.receipt_long_rounded,
                  size: 18.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w),
                const SectionTitle(title: 'Price Details'),
              ],
            ),
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
              final totalSavings = controller.productDiscount + controller.couponDiscount;
              if (totalSavings > 0) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xFF16A34A).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'Saving Rs. ${totalSavings.toStringAsFixed(0)}',
                    style: AppTextStyles.caption.copyWith(
                      color: const Color(0xFF16A34A),
                      fontWeight: FontWeight.w700,
                      fontSize: 10.5.sp,
                    ),
                  ),
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
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              color: colors.border.withValues(alpha: 0.9),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Obx(() {
            final subtotal = controller.subtotal;
            final productDiscount = controller.productDiscount;
            final couponDiscount = controller.couponDiscount;
            final shipping = controller.shipping;
            final grandTotal = controller.grandTotal;
            final totalSavings = productDiscount + couponDiscount;
            final itemsCount = controller.cartItems.length;

            return Column(
              children: [
                // Items Subtotal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Items Subtotal',
                          style: AppTextStyles.body.copyWith(
                            color: colors.textSecondary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (itemsCount > 0) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 1.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: colors.panelSecondary,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              '$itemsCount items',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 9.5.sp,
                                color: colors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      'Rs. ${subtotal.toStringAsFixed(0)}',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5.sp,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),

                // Catalog Promotional Discount
                if (productDiscount > 0) ...[
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Catalog Discount',
                            style: AppTextStyles.body.copyWith(
                              color: colors.textSecondary,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'PROMO',
                              style: TextStyle(
                                color: const Color(0xFF16A34A),
                                fontSize: 8.5.sp,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '- Rs. ${productDiscount.toStringAsFixed(0)}',
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5.sp,
                          color: const Color(0xFF16A34A),
                        ),
                      ),
                    ],
                  ),
                ],

                // Coupon Discount
                if (couponDiscount > 0) ...[
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Coupon Discount',
                            style: AppTextStyles.body.copyWith(
                              color: colors.textSecondary,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (controller.appliedCouponCode.value.isNotEmpty) ...[
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 1.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                controller.appliedCouponCode.value.toUpperCase(),
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 8.5.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '- Rs. ${couponDiscount.toStringAsFixed(0)}',
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5.sp,
                          color: const Color(0xFF16A34A),
                        ),
                      ),
                    ],
                  ),
                ],

                // Shipping Fee
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Delivery Fee',
                          style: AppTextStyles.body.copyWith(
                            color: colors.textSecondary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.local_shipping_outlined,
                          size: 14.sp,
                          color: colors.textSecondary,
                        ),
                      ],
                    ),
                    shipping == 0
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'FREE DELIVERY',
                              style: TextStyle(
                                color: const Color(0xFF16A34A),
                                fontWeight: FontWeight.w800,
                                fontSize: 10.sp,
                                letterSpacing: 0.4,
                              ),
                            ),
                          )
                        : Text(
                            'Rs. ${shipping.toStringAsFixed(0)}',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5.sp,
                              color: colors.textPrimary,
                            ),
                          ),
                  ],
                ),

                // Taxes Included Note
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Taxes & Duties',
                      style: AppTextStyles.body.copyWith(
                        color: colors.textSecondary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Included in Price',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.5.sp,
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // Total Savings Banner if savings > 0
                if (totalSavings > 0) ...[
                  SizedBox(height: 14.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: const Color(0xFF16A34A).withValues(alpha: 0.25),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          size: 15.sp,
                          color: const Color(0xFF16A34A),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'You are saving Rs. ${totalSavings.toStringAsFixed(0)} on this order!',
                            style: TextStyle(
                              color: const Color(0xFF16A34A),
                              fontWeight: FontWeight.w700,
                              fontSize: 11.5.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: colors.border.withValues(alpha: 0.7),
                  ),
                ),

                // Final Payable Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Payable',
                          style: AppTextStyles.heading2.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Pay via Cash on Delivery',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 10.5.sp,
                            color: colors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rs. ${grandTotal.toStringAsFixed(0)}',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 20.sp,
                        letterSpacing: -0.3,
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

    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.8),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Micro Trust & Guarantee Strip
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 12.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: 4.w),
                Text(
                  '100% Secure Checkout',
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text('•', style: TextStyle(color: colors.textSecondary, fontSize: 10.sp)),
                ),
                Icon(
                  Icons.payments_outlined,
                  size: 12.sp,
                  color: AppColors.goldLight,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Pay on Delivery',
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text('•', style: TextStyle(color: colors.textSecondary, fontSize: 10.sp)),
                ),
                Icon(
                  Icons.published_with_changes_rounded,
                  size: 12.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Easy Returns',
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // Main Pricing + CTA Row
            Row(
              children: [
                // Total Price Column
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'TOTAL (COD)',
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Obx(
                        () => FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Rs. ${controller.grandTotal.toStringAsFixed(0)}',
                            style: AppTextStyles.heading2.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w900,
                              fontSize: 20.sp,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Taxes included',
                        style: TextStyle(
                          color: colors.textSecondary.withValues(alpha: 0.7),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                // Place Order Button
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    height: 50.h,
                    child: Obx(() {
                      final isBusy = controller.isPlacingOrder.value;

                      return BounceTap(
                        scaleBound: 0.95,
                        onTap: isBusy ? () {} : () => controller.placeOrder(context),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                Color(0xFF1C6335),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.goldLight.withValues(alpha: 0.4),
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                blurRadius: 14,
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
                                        strokeWidth: 2.2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Confirming...',
                                      style: AppTextStyles.button.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lock_outline_rounded,
                                      size: 16.sp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Place Order',
                                      style: AppTextStyles.button.copyWith(
                                        fontSize: 14.5.sp,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 16.sp,
                                      color: Colors.white.withValues(alpha: 0.85),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    }),
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

