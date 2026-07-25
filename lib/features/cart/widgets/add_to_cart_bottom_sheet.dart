import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../controllers/cart_controller.dart';
import 'quantity_selector.dart';

class AddToCartBottomSheet extends StatefulWidget {
  final Map<String, dynamic> product;

  const AddToCartBottomSheet({
    super.key,
    required this.product,
  });

  /// Static helper to show the bottom sheet cleanly from anywhere.
  static Future<void> show(
    BuildContext context,
    Map<String, dynamic> product,
  ) async {
    await Get.bottomSheet(
      AddToCartBottomSheet(product: product),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int quantity = 1;
  bool _isSubmitting = false;

  double get _unitPrice {
    final priceRaw = widget.product['price'];
    if (priceRaw == null) return 0.0;
    final cleaned = priceRaw.toString().replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  double get _totalPrice => _unitPrice * quantity;

  String _formatPrice(double val) {
    if (val % 1 == 0) {
      return val.toInt().toString();
    }
    return val.toStringAsFixed(2);
  }

  void _increment() {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _onAddToCart() {
    if (_isSubmitting) return;
    _isSubmitting = true;

    final CartController cartController = Get.find<CartController>(
      tag: CartController.tag,
    );

    final bool isExisting = cartController.addToCart(
      widget.product,
      quantity: quantity,
      showSnackbar: false,
    );

    if (Get.isBottomSheetOpen == true) {
      Get.back();
    } else {
      Get.back();
    }

    Future.delayed(const Duration(milliseconds: 150), () {
      cartController.showSuccessSnackbar(
        quantity: quantity,
        isExisting: isExisting,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.product['name']?.toString() ?? 'Product';
    final String category = widget.product['category']?.toString() ?? 'General';
    final String imageUrl = widget.product['image']?.toString() ?? '';

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.of(context).cardBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Drag Handle Pill
            Center(
              child: Container(
                width: 44.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.of(context).border,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// Header with Product Image + Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: AppColors.of(context).cardBackground,
                              highlightColor: AppColors.primary.withValues(alpha: 0.1),
                              child: Container(color: AppColors.of(context).cardBackground),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.of(context).panelSecondary,
                              child: const Icon(Icons.image_not_supported_outlined),
                            ),
                          )
                        : Container(
                            color: AppColors.of(context).panelSecondary,
                            child: const Icon(Icons.shopping_bag_outlined),
                          ),
                  ),
                ),

                SizedBox(width: 14.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.of(context).textPrimary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          category,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Rs. ${_formatPrice(_unitPrice)}',
                        style: AppTextStyles.heading2.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                BounceTap(
                  onTap: () => Get.back(),
                  scaleBound: 0.9,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).panelSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 20.sp,
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
            Divider(color: AppColors.of(context).border),
            SizedBox(height: 16.h),

            /// Quantity Selector Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Quantity',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
                QuantitySelector(
                  quantity: quantity,
                  onIncrement: _increment,
                  onDecrement: _decrement,
                  minQuantity: 1,
                  height: 40,
                  iconSize: 20,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            /// Total Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Text(
                    'Rs. ${_formatPrice(_totalPrice)}',
                    key: ValueKey<double>(_totalPrice),
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            /// Full-width Add to Cart Button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: BounceTap(
                onTap: _onAddToCart,
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
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Add to Cart',
                        style: AppTextStyles.button.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
