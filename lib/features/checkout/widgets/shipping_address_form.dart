import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/checkout_controller.dart';
import 'app_text_field.dart';
import 'section_title.dart';

class ShippingAddressForm extends StatelessWidget {
  const ShippingAddressForm({super.key});

  static const List<String> provinces = [
    'Sindh',
    'Punjab',
    'Khyber Pakhtunkhwa',
    'Balochistan',
    'Islamabad Capital Territory',
    'Gilgit-Baltistan',
    'Azad Jammu & Kashmir',
  ];

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CheckoutController>();
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Contact Information'),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            children: [
              AppTextField(
                controller: c.nameController,
                label: 'Full Name *',
                hint: 'e.g. Mahnoor Anwar',
                keyboardType: TextInputType.name,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Full name is required' : null,
              ),
              SizedBox(height: 12.h),
              AppTextField(
                controller: c.emailController,
                label: 'Email Address *',
                hint: 'e.g. customer@example.com',
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  final val = v?.trim() ?? '';
                  if (val.isEmpty) return 'Email is required';
                  if (!GetUtils.isEmail(val)) return 'Enter a valid email address';
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              AppTextField(
                controller: c.phoneController,
                label: 'Phone Number *',
                hint: 'e.g. +923350312356',
                keyboardType: TextInputType.phone,
                validator: (v) {
                  final val = v?.trim() ?? '';
                  if (val.isEmpty) return 'Phone number is required';
                  if (val.length < 10) return 'Enter a valid phone number';
                  return null;
                },
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        const SectionTitle(title: 'Shipping Address'),
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
              // Province Dropdown / Selector
              Text(
                'Province *',
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 6.h),
              Obx(() {
                final selectedProvince = c.selectedProvince.value;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: colors.panelSecondary,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: colors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedProvince.isNotEmpty ? selectedProvince : null,
                      hint: Text(
                        'Select Province',
                        style: AppTextStyles.body.copyWith(
                          color: colors.textSecondary.withValues(alpha: 0.6),
                          fontSize: 13.sp,
                        ),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: colors.textPrimary,
                        size: 22.sp,
                      ),
                      dropdownColor: colors.cardBackground,
                      borderRadius: BorderRadius.circular(14.r),
                      items: provinces.map((String prov) {
                        return DropdownMenuItem<String>(
                          value: prov,
                          child: Text(
                            prov,
                            style: AppTextStyles.body.copyWith(
                              fontSize: 13.sp,
                              color: colors.textPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        if (val != null) {
                          c.selectedProvince.value = val;
                        }
                      },
                    ),
                  ),
                );
              }),

              SizedBox(height: 12.h),

              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: c.cityController,
                      label: 'City *',
                      hint: 'e.g. Karachi / Lahore',
                      keyboardType: TextInputType.text,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'City is required'
                          : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppTextField(
                      controller: c.areaController,
                      label: 'Area / Neighborhood *',
                      hint: 'e.g. Malir / DHA',
                      keyboardType: TextInputType.text,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Area is required'
                          : null,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              AppTextField(
                controller: c.addressController,
                label: 'Complete Street Address *',
                hint: 'House / Flat #, Street, Block',
                keyboardType: TextInputType.streetAddress,
                maxLines: 2,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Full address is required'
                    : null,
              ),

              SizedBox(height: 12.h),

              AppTextField(
                controller: c.landmarkController,
                label: 'Nearby Landmark (Optional)',
                hint: 'e.g. Near Mega Mall / Disco Bakery',
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 12.h),

              AppTextField(
                controller: c.deliveryInstructionsController,
                label: 'Delivery Instructions (Optional)',
                hint: 'e.g. Call before arrival / leave with guard',
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 12.h),

              AppTextField(
                controller: c.notesController,
                label: 'Order Notes (Optional)',
                hint: 'Any special requests or instructions',
                keyboardType: TextInputType.text,
                maxLines: 2,
              ),

              SizedBox(height: 8.h),

              // Save to Address Book Toggle
              Obx(() => Row(
                    children: [
                      Checkbox(
                        value: c.saveToAddressBook.value,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        onChanged: (val) {
                          c.saveToAddressBook.value = val ?? false;
                        },
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            c.saveToAddressBook.value = !c.saveToAddressBook.value;
                          },
                          child: Text(
                            'Save this address for future orders',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 12.sp,
                              color: colors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
