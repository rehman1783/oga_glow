import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/shipping_address_form.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Center(child: Text('Checkout', style: AppTextStyles.heading2)),
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
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShippingAddressForm(),

                        SizedBox(height: 18.h),
                        Text('Payment', style: AppTextStyles.heading2),
                        SizedBox(height: 12.h),

                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.border.withOpacity(0.8),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _paymentOption(
                                value: 'card',
                                title: 'Card',
                                subtitle: 'Visa / MasterCard / RuPay',
                                icon: Icons.credit_card_rounded,
                              ),
                              SizedBox(height: 10.h),
                              _paymentOption(
                                value: 'cod',
                                title: 'Cash on Delivery',
                                subtitle: 'Pay when you receive your order',
                                icon: Icons.money_rounded,
                              ),
                              SizedBox(height: 12.h),
                              if (controller.paymentMethod.value == 'card')
                                _cardFields(),
                              if (controller.paymentMethod.value == 'cod')
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Text(
                                    'You selected COD. Your card details are not required.',
                                    style: AppTextStyles.caption,
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

              // Bottom summary / CTA
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.8),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text('Total', style: AppTextStyles.caption),
                          const Spacer(),
                          Obx(() => Text('Rs. ${controller.total}', style: AppTextStyles.heading2)),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
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
                          icon: const Icon(Icons.check_circle_rounded),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          label: Text(
                            'Place Order',
                            style: AppTextStyles.button,
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
      ),
    );
  }

  Widget _paymentOption({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () => controller.setPaymentMethod(value),
      child: Obx(() {
        final selected = controller.paymentMethod.value == value;
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: selected ? AppColors.secondary : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: selected ? AppColors.primary.withOpacity(0.35) : AppColors.border.withOpacity(0.7),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  icon,
                  color: selected ? AppColors.white : AppColors.textPrimary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.heading2),
                    SizedBox(height: 2.h),
                    Text(subtitle, style: AppTextStyles.caption),
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
        );
      }),
    );
  }

  Widget _cardFields() {
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();

    // Demo MVP: local controllers (no dispose to keep refactor minimal).

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
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'This is a demo UI. Card processing is not implemented.',
            style: AppTextStyles.caption,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
        ),
      ],
    );
  }
}

