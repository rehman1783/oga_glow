import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../controllers/checkout_controller.dart';
import 'section_title.dart';

class OrderCouponSection extends GetView<CheckoutController> {
  const OrderCouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Promo & Coupons'),
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: colors.panelSecondary,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: colors.border),
                      ),
                      child: TextField(
                        controller: controller.couponController,
                        textCapitalization: TextCapitalization.characters,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                          letterSpacing: 1.1,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter coupon code (e.g. SUMMER40)',
                          hintStyle: AppTextStyles.caption.copyWith(
                            color: colors.textSecondary.withValues(alpha: 0.6),
                            fontSize: 12.sp,
                            letterSpacing: 0,
                          ),
                          prefixIcon: Icon(
                            Icons.discount_outlined,
                            color: AppColors.primary,
                            size: 20.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Obx(() {
                    final isApplied = controller.appliedCouponCode.value.isNotEmpty;
                    final isBusy = controller.isApplyingCoupon.value;

                    return BounceTap(
                      onTap: isBusy
                          ? () {}
                          : () {
                              if (isApplied) {
                                controller.removeCoupon();
                              } else {
                                controller.applyCoupon();
                              }
                            },
                      child: Container(
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        decoration: BoxDecoration(
                          gradient: isApplied
                              ? null
                              : const LinearGradient(
                                  colors: [AppColors.primary, AppColors.primaryLight],
                                ),
                          color: isApplied ? AppColors.error.withValues(alpha: 0.1) : null,
                          borderRadius: BorderRadius.circular(14.r),
                          border: isApplied
                              ? Border.all(color: AppColors.error.withValues(alpha: 0.3))
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: isBusy
                            ? SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                isApplied ? 'Remove' : 'Apply',
                                style: AppTextStyles.button.copyWith(
                                  fontSize: 13.sp,
                                  color: isApplied ? AppColors.error : AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    );
                  }),
                ],
              ),

              // Coupon error / success feedback
              Obx(() {
                final couponError = controller.couponError.value;
                final appliedCode = controller.appliedCouponCode.value;
                final discount = controller.couponDiscount;

                if (couponError.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h, left: 4.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 14.sp,
                          color: AppColors.error,
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            couponError,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.error,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (appliedCode.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 2.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 14.sp,
                            color: AppColors.success,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Coupon "$appliedCode" applied (- Rs. ${discount.toStringAsFixed(0)})',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ],
    );
  }
}
