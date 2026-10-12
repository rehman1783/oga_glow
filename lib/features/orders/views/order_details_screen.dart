import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/constants/order_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/custom_network_image.dart';
import 'package:oga_glow/core/widgets/custom_snackbar.dart';
import 'package:oga_glow/core/widgets/fade_slide_transition.dart';
import 'package:oga_glow/features/auth/controllers/auth_controller.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import '../widgets/order_status_chip.dart';
import '../widgets/order_timeline.dart';
import '../widgets/order_summary_card.dart';

/// Helper model for computed pricing breakdown.
class _PriceInfo {
  final double displayUnitPrice;
  final double displayDiscountedPrice;
  final double discountSavings;
  final double shippingFee;

  const _PriceInfo({
    required this.displayUnitPrice,
    required this.displayDiscountedPrice,
    required this.discountSavings,
    required this.shippingFee,
  });
}

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
                      value: _getCustomerName(order),
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

  /// Builds the product header section with real image, name, short Order ID, and status.
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product main picture instead of placeholder shopping icon
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  color: AppColors.of(context).panelSecondary,
                  child: _buildProductImage(order, context),
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

                    // Order ID row with copy functionality
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Order ID: ${order.orderId}',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.of(context).textSecondary,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: order.orderId));
                            CustomSnackbar.showSuccess(
                              title: 'Copied',
                              message: 'Order ID ${order.orderId} copied to clipboard',
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.copy_rounded,
                                  size: 11.sp,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  'COPY',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  /// Builds the product main image widget.
  Widget _buildProductImage(OrderModel order, BuildContext context) {
    final img = _getProductImageUrl(order);

    if (img.startsWith('http://') || img.startsWith('https://')) {
      return CustomNetworkImage(
        imageUrl: img,
        fit: BoxFit.cover,
        width: 80.w,
        height: 80.w,
        errorWidget: (c, url, err) => _buildImageFallback(),
      );
    }

    if (img.startsWith('assets/')) {
      return Image.asset(
        img,
        fit: BoxFit.cover,
        width: 80.w,
        height: 80.w,
        errorBuilder: (c, e, s) => _buildImageFallback(),
      );
    }

    if (img.isNotEmpty) {
      return CustomNetworkImage(
        imageUrl: img,
        fit: BoxFit.cover,
        width: 80.w,
        height: 80.w,
        errorWidget: (c, url, err) => _buildImageFallback(),
      );
    }

    return _buildImageFallback();
  }

  Widget _buildImageFallback() {
    return Center(
      child: Icon(
        Icons.spa_rounded,
        size: 32.sp,
        color: AppColors.primary.withValues(alpha: 0.5),
      ),
    );
  }

  /// Resolves the actual product image URL from OrderModel or catalog.
  String _getProductImageUrl(OrderModel order) {
    final img = order.productImage.trim();
    if (img.isNotEmpty && !img.contains('placeholder')) {
      return img;
    }
    if (Get.isRegistered<HomeController>()) {
      try {
        final home = Get.find<HomeController>();
        final match = home.allProducts.firstWhereOrNull(
          (p) =>
              p.name.trim().toLowerCase() ==
              order.productName.trim().toLowerCase(),
        );
        if (match != null && match.mainImageUrl.isNotEmpty) {
          return match.mainImageUrl;
        }
      } catch (_) {}
    }
    return img;
  }

  /// Resolves the real customer name from OrderModel or active Auth profile.
  String _getCustomerName(OrderModel order) {
    if (order.customerName.isNotEmpty &&
        order.customerName.trim().toLowerCase() != 'valued customer') {
      return order.customerName.trim();
    }
    if (Get.isRegistered<AuthController>()) {
      try {
        final authUser = Get.find<AuthController>().currentUser.value;
        if (authUser != null && authUser.name.trim().isNotEmpty) {
          return authUser.name.trim();
        }
      } catch (_) {}
    }
    return order.customerName.isNotEmpty
        ? order.customerName
        : 'Valued Customer';
  }

  /// Calculates accurate price breakdown including discounted price and savings.
  _PriceInfo _resolvePrices(OrderModel order) {
    double unitPrice = order.unitPrice;
    double? originalPrice = order.originalPrice;
    double? discountedPrice = order.discountedPrice;
    double discountSavings = order.discountAmount;
    double shippingFee = order.shippingPrice;

    // Check catalog if original or discounted price is not explicitly set
    if (Get.isRegistered<HomeController>()) {
      try {
        final home = Get.find<HomeController>();
        final match = home.allProducts.firstWhereOrNull(
          (p) =>
              p.name.trim().toLowerCase() ==
              order.productName.trim().toLowerCase(),
        );
        if (match != null) {
          if (match.hasDiscount) {
            originalPrice ??= match.price;
            discountedPrice ??= match.finalPrice;
            if (discountSavings <= 0) {
              discountSavings =
                  (match.price - match.finalPrice) * order.quantity;
            }
          }
          if (shippingFee <= 0 && match.shippingPrice > 0) {
            shippingFee = match.shippingPrice;
          }
        }
      } catch (_) {}
    }

    if (discountedPrice == null) {
      if (originalPrice != null && originalPrice > unitPrice) {
        discountedPrice = unitPrice;
      } else if (discountSavings > 0 && unitPrice > 0) {
        discountedPrice = unitPrice;
        originalPrice ??=
            unitPrice + (discountSavings / (order.quantity > 0 ? order.quantity : 1));
      } else {
        discountedPrice = unitPrice;
      }
    }

    if (originalPrice == null) {
      if (discountSavings > 0 && discountedPrice > 0) {
        originalPrice =
            discountedPrice + (discountSavings / (order.quantity > 0 ? order.quantity : 1));
      } else {
        originalPrice = discountedPrice;
      }
    }

    if (shippingFee <= 0 &&
        order.totalPrice > (discountedPrice * order.quantity)) {
      shippingFee = order.totalPrice - (discountedPrice * order.quantity);
    }

    return _PriceInfo(
      displayUnitPrice:
          originalPrice > discountedPrice ? originalPrice : discountedPrice,
      displayDiscountedPrice: discountedPrice,
      discountSavings: discountSavings > 0
          ? discountSavings
          : (originalPrice > discountedPrice
              ? (originalPrice - discountedPrice) * order.quantity
              : 0),
      shippingFee: shippingFee,
    );
  }

  /// Builds the order summary card with quantity, unit price, discounted price, total, etc.
  Widget _buildOrderSummaryCard(OrderModel order, bool isDark) {
    return Builder(
      builder: (context) {
        final prices = _resolvePrices(order);

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

              // Unit Price
              _summaryRow(
                context,
                prices.discountSavings > 0 ? 'Regular Unit Price' : 'Unit Price',
                'Rs. ${prices.displayUnitPrice.toStringAsFixed(0)}',
                strikethrough: prices.discountSavings > 0,
              ),
              Divider(height: 20, color: AppColors.of(context).border),

              // Discounted Price (always shown per requirement)
              _summaryRow(
                context,
                'Discounted Price',
                'Rs. ${prices.displayDiscountedPrice.toStringAsFixed(0)}',
                valueColor: AppColors.primary,
                isHighlight: true,
              ),

              // Optional Discount Savings row if a promo was applied
              if (prices.discountSavings > 0) ...[
                Divider(height: 20, color: AppColors.of(context).border),
                _summaryRow(
                  context,
                  'Discount Savings',
                  '- Rs. ${prices.discountSavings.toStringAsFixed(0)}',
                  valueColor: const Color(0xFF16A34A),
                ),
              ],

              // Delivery Fee
              Divider(height: 20, color: AppColors.of(context).border),
              _summaryRow(
                context,
                'Delivery Fee',
                prices.shippingFee > 0
                    ? 'Rs. ${prices.shippingFee.toStringAsFixed(0)}'
                    : 'Free Delivery',
                valueColor: prices.shippingFee == 0
                    ? const Color(0xFF16A34A)
                    : null,
              ),

              Divider(height: 20, color: AppColors.of(context).border),
              _summaryRow(context, 'Payment Method', order.paymentMethod),
              Divider(height: 20, color: AppColors.of(context).border),
              _summaryRow(context, 'Order Date', order.orderDate),
              Divider(height: 20, color: AppColors.of(context).border),

              // Total Price in Rs.
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
                    'Rs. ${order.totalPrice.toStringAsFixed(0)}',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w900,
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

  Widget _summaryRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
    bool strikethrough = false,
    bool isHighlight = false,
  }) {
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
            fontSize: isHighlight ? 13.5.sp : 13.sp,
            fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? AppColors.of(context).textPrimary,
            decoration:
                strikethrough ? TextDecoration.lineThrough : TextDecoration.none,
            decorationColor: AppColors.of(context).textSecondary,
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
