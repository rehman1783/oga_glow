import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/empty_cart.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../../core/widgets/fade_slide_transition.dart';
import '../../drawer/widgets/app_drawer.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.find<CartController>(
    tag: CartController.tag,
  );

  String _formatTotal(double val) {
    if (val % 1 == 0) {
      return val.toInt().toString();
    }
    return val.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(64.h),
        child: AppBar(
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.more_vert_rounded, color: colors.textPrimary),
          ),
          title: Text(
            'Shopping Bag',
            style: AppTextStyles.heading2.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
            ),
          ),
          actions: [
            Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const SizedBox.shrink();
              }
              return TextButton.icon(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Clear Shopping Bag',
                    titleStyle: AppTextStyles.heading2.copyWith(fontSize: 16.sp),
                    middleText: 'Are you sure you want to remove all items from your bag?',
                    middleTextStyle: AppTextStyles.body.copyWith(
                      color: colors.textSecondary,
                      fontSize: 13.sp,
                    ),
                    textConfirm: 'Clear All',
                    textCancel: 'Cancel',
                    confirmTextColor: Colors.white,
                    buttonColor: AppColors.error,
                    cancelTextColor: colors.textPrimary,
                    radius: 18.r,
                    onConfirm: () {
                      cartController.clearCart();
                      Get.back();
                    },
                  );
                },
                icon: Icon(Icons.delete_sweep_rounded, color: AppColors.error, size: 18.sp),
                label: Text(
                  'Clear',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }),
          ],
          scrolledUnderElevation: 0,
        ),
      ),
      body: Obx(() {
        final items = cartController.cartItems;

        if (items.isEmpty) {
          return const EmptyCart();
        }

        final double subtotal = cartController.totalSubtotal;
        final double discount = cartController.totalDiscount;

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return FadeSlideTransition(
                    index: index,
                    child: CartItemCard(product: items[index], index: index),
                  );
                },
              ),
            ),
            FadeSlideTransition(
              index: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child: Container(
                  padding: EdgeInsets.all(18.w),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: colors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 18,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (discount > 0) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.savings_outlined,
                                color: AppColors.success,
                                size: 16.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'You are saving Rs. ${_formatTotal(discount)} on this order!',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.5.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estimated Subtotal',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textSecondary,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Shipping calculated at checkout',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: colors.textSecondary.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Rs. ${_formatTotal(subtotal)}',
                            style: AppTextStyles.heading2.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w900,
                              fontSize: 19.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: BounceTap(
                          scaleBound: 0.96,
                          onTap: () {
                            Get.toNamed(AppRoutes.checkout);
                          },
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
                                  color: AppColors.primary.withValues(
                                    alpha: 0.32,
                                  ),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppColors.white,
                                  size: 17,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Proceed to Checkout',
                                  style: AppTextStyles.button.copyWith(
                                    fontSize: 14.5.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.4,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 17.sp,
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
