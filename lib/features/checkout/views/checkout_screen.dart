import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/shipping_address_form.dart';
import '../widgets/app_text_field.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../../core/widgets/fade_slide_transition.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text('Checkout', style: AppTextStyles.heading2.copyWith(fontSize: 18)),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Staggered Entrance 0: Address Form Card
                        FadeSlideTransition(
                          index: 0,
                          child: const ShippingAddressForm(),
                        ),

                        SizedBox(height: 24.h),
                        
                        // Staggered Entrance 1: Payment Selection Section
                        FadeSlideTransition(
                          index: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Payment Method', style: AppTextStyles.heading2),
                              SizedBox(height: 12.h),

                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border.all(
                                    color: AppColors.border.withOpacity(0.5),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _paymentOption(
                                      value: 'card',
                                      title: 'Card Payment',
                                      subtitle: 'Visa / MasterCard / RuPay',
                                      icon: Icons.credit_card_rounded,
                                    ),
                                    SizedBox(height: 12.h),
                                    _paymentOption(
                                      value: 'cod',
                                      title: 'Cash on Delivery',
                                      subtitle: 'Pay when you receive your order',
                                      icon: Icons.money_rounded,
                                    ),
                                    
                                    // Smoothly animated dynamic height fields container
                                    AnimatedSize(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: controller.paymentMethod.value == 'card'
                                            ? Column(
                                                key: const ValueKey('card_fields'),
                                                children: [
                                                  SizedBox(height: 16.h),
                                                  _cardFields(),
                                                ],
                                              )
                                            : Column(
                                                key: const ValueKey('cod_fields'),
                                                children: [
                                                  SizedBox(height: 16.h),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                                    child: Text(
                                                      'You selected Cash on Delivery. Card details are not required to complete this order.',
                                                      style: AppTextStyles.caption.copyWith(
                                                        color: AppColors.textSecondary,
                                                        height: 1.4,
                                                      ),
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

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom summary / CTA Card
              FadeSlideTransition(
                index: 2,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                  child: Container(
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: AppColors.border.withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total Amount', 
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Obx(() => Text(
                                  'Rs. ${controller.total}', 
                                  style: AppTextStyles.heading2.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: BounceTap(
                            onTap: () {
                              if (!controller.formKey.currentState!.validate()) {
                                Get.snackbar(
                                  'Fix details',
                                  'Please complete the required fields.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppColors.cardBackground,
                                  colorText: AppColors.textPrimary,
                                  borderRadius: 14.r,
                                );
                                return;
                              }

                              Get.snackbar(
                                  'Order placed',
                                  'Place Order will be connected to backend later.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppColors.cardBackground,
                                  colorText: AppColors.textPrimary,
                                  borderRadius: 14.r,
                                );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.primary, AppColors.primaryLight],
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check_circle_rounded, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Place Order', 
                                    style: AppTextStyles.button.copyWith(fontSize: 14.sp),
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
          ),
        ),
      ),
    );
  }

  Widget _paymentOption({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Obx(() {
      final selected = controller.paymentMethod.value == value;
      return BounceTap(
        onTap: () => controller.setPaymentMethod(value),
        scaleBound: 0.97,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: selected ? AppColors.secondary.withOpacity(0.4) : AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border.withOpacity(0.6),
              width: selected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: selected ? AppColors.white : AppColors.textPrimary,
                  size: 20,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title, 
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(subtitle, style: AppTextStyles.caption.copyWith(fontSize: 11.sp)),
                  ],
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: controller.paymentMethod.value,
                activeColor: AppColors.primary,
                onChanged: (v) {
                  if (v == null) return;
                  controller.setPaymentMethod(v);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _cardFields() {
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();

    return Column(
      children: [
        _textField(
          controller: cardNumberController,
          label: 'Card Number',
          hint: '1234 5678 9012 3456',
          keyboardType: TextInputType.number,
          validator: (v) {
            final val = v?.replaceAll(' ', '') ?? '';
            if (val.isEmpty) return 'Card number is required';
            if (val.length < 12) return 'Enter a valid card number';
            return null;
          },
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _textField(
                controller: expiryController,
                label: 'Expiry',
                hint: 'MM/YY',
                keyboardType: TextInputType.datetime,
                validator: (v) {
                  final val = v?.trim() ?? '';
                  if (val.isEmpty) return 'Expiry is required';
                  if (!val.contains('/')) return 'Use format MM/YY';
                  return null;
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _textField(
                controller: cvvController,
                label: 'CVV',
                hint: '123',
                keyboardType: TextInputType.number,
                validator: (v) {
                  final val = v?.trim() ?? '';
                  if (val.isEmpty) return 'CVV is required';
                  if (val.length < 3) return 'Enter a valid CVV';
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'This is a demo UI. Card processing is not implemented.',
            style: AppTextStyles.caption.copyWith(color: Colors.black26),
          ),
        ),
      ],
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required TextInputType keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }
}
