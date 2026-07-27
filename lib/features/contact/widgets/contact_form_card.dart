import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/custom_text_field.dart';
import 'package:oga_glow/core/widgets/primary_button.dart';
import 'package:oga_glow/features/contact/controllers/contact_controller.dart';

class ContactFormCard extends GetView<ContactController> {
  const ContactFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send us a message',
            style: AppTextStyles.heading2.copyWith(
              color: colors.textPrimary,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            controller: controller.nameController,
            labelHint: 'Name',
            hintText: 'Enter your full name',
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: controller.emailController,
            labelHint: 'Email',
            keyboardType: TextInputType.emailAddress,
            hintText: 'you@example.com',
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: controller.subjectController,
            labelHint: 'Subject',
            hintText: 'What would you like to discuss?',
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: controller.messageController,
            labelHint: 'Message',
            hintText: 'Write your message here',
          ),
          SizedBox(height: 12.h),
          Obx(() {
            return controller.formError.value.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      controller.formError.value,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  );
          }),
          Obx(() {
            return PrimaryButton(
              title: 'Send Message',
              isLoading: controller.isSubmitting.value,
              onPressed: controller.submitContactForm,
            );
          }),
        ],
      ),
    );
  }
}
