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
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colors.border.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.rate_review_rounded,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send us a message',
                    style: AppTextStyles.heading2.copyWith(
                      color: colors.textPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'We typically reply within 24 hours',
                    style: AppTextStyles.caption.copyWith(
                      color: colors.textSecondary,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            controller: controller.nameController,
            labelHint: 'Full Name',
            hintText: 'Enter your full name',
            prefixIcon: const Icon(Icons.person_outline_rounded),
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            controller: controller.emailController,
            labelHint: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            hintText: 'you@example.com',
            prefixIcon: const Icon(Icons.mail_outline_rounded),
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            controller: controller.subjectController,
            labelHint: 'Subject',
            hintText: 'What would you like to discuss?',
            prefixIcon: const Icon(Icons.subject_rounded),
          ),
          SizedBox(height: 12.h),
          CustomTextField(
            controller: controller.messageController,
            labelHint: 'Your Message',
            hintText: 'Write your detailed message here...',
            maxLines: 4,
            prefixIcon: const Icon(Icons.edit_note_rounded),
          ),
          SizedBox(height: 12.h),
          Obx(() {
            return controller.formError.value.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 16.sp,
                          color: AppColors.error,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            controller.formError.value,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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

