import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';
import 'app_text_field.dart';
import 'section_title.dart';
import '../../../core/theme/app_colors.dart';

class ShippingAddressForm extends StatelessWidget {
  const ShippingAddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Shipping Address'),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: AppColors.radius,
            border: Border.all(color: AppColors.border.withOpacity(0.8)),
          ),
          child: Column(
            children: [
              AppTextField(
                controller: c.nameController,
                label: 'Full Name',
                hint: 'e.g. Abdul Rahman',
                keyboardType: TextInputType.name,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),
              SizedBox(height: 12.h),
              AppTextField(
                controller: c.phoneController,
                label: 'Phone',
                hint: 'e.g. 9876543210',
                keyboardType: TextInputType.phone,
                validator: (v) {
                  final val = v?.trim() ?? '';
                  if (val.isEmpty) return 'Phone is required';
                  if (val.length < 10) return 'Enter a valid phone number';
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              AppTextField(
                controller: c.addressController,
                label: 'Address',
                hint: 'House/Street/Area',
                keyboardType: TextInputType.streetAddress,
                maxLines: 3,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Address is required'
                    : null,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: c.cityController,
                      label: 'City',
                      hint: 'e.g. Mumbai',
                      keyboardType: TextInputType.text,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'City is required'
                          : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppTextField(
                      controller: c.pincodeController,
                      label: 'Pincode',
                      hint: 'e.g. 400001',
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        final val = v?.trim() ?? '';
                        if (val.isEmpty) return 'Pincode is required';
                        if (val.length < 5) return 'Enter a valid pincode';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
