import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';

class ContactInfoSection extends StatelessWidget {
  final ContactInfoModel? contactInfo;
  final Function(String) onPhoneTap;
  final Function(String) onEmailTap;
  final Function(String) onUrlTap;

  const ContactInfoSection({
    super.key,
    required this.contactInfo,
    required this.onPhoneTap,
    required this.onEmailTap,
    required this.onUrlTap,
  });

  @override
  Widget build(BuildContext context) {
    if (contactInfo == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Head Office', Icons.business_rounded),
        if (contactInfo!.headOffice != null) ...[
          SizedBox(height: 8.h),
          _buildInfoCard(
            context,
            title: contactInfo!.headOffice!.city ?? 'Head Office',
            subtitle: contactInfo!.headOffice!.address ?? 'Address unavailable',
            icon: Icons.location_on_rounded,
          ),
        ],
        SizedBox(height: 16.h),
        _buildSectionTitle(context, 'Sub Offices', Icons.location_city_rounded),
        SizedBox(height: 8.h),
        if (contactInfo!.subOffices.isNotEmpty)
          ...contactInfo!.subOffices.map(
            (office) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildInfoCard(
                context,
                title: office.city ?? 'Office',
                subtitle: office.address ?? 'Address unavailable',
                icon: Icons.apartment_rounded,
              ),
            ),
          )
        else
          _buildInfoCard(
            context,
            title: 'No sub offices',
            subtitle: 'No additional office details currently available.',
            icon: Icons.apartment_rounded,
          ),
        SizedBox(height: 16.h),
        _buildSectionTitle(context, 'Emails', Icons.email_rounded),
        SizedBox(height: 8.h),
        if (contactInfo!.emails.isNotEmpty)
          ...contactInfo!.emails.map(
            (email) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: GestureDetector(
                onTap: () => onEmailTap(email),
                child: _buildInfoCard(
                  context,
                  title: email,
                  subtitle: 'Tap to send an email',
                  icon: Icons.mail_outline_rounded,
                ),
              ),
            ),
          )
        else
          _buildInfoCard(
            context,
            title: 'Email unavailable',
            subtitle: 'No email address available right now.',
            icon: Icons.mail_outline_rounded,
          ),
        SizedBox(height: 16.h),
        _buildSectionTitle(context, 'Phone Numbers', Icons.phone_rounded),
        SizedBox(height: 8.h),
        if (contactInfo!.phoneNumbers.isNotEmpty)
          ...contactInfo!.phoneNumbers.map(
            (phone) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: GestureDetector(
                onTap: () => onPhoneTap(phone),
                child: _buildInfoCard(
                  context,
                  title: phone,
                  subtitle: 'Tap to call',
                  icon: Icons.call_rounded,
                ),
              ),
            ),
          )
        else
          _buildInfoCard(
            context,
            title: 'Phone unavailable',
            subtitle: 'No phone number available right now.',
            icon: Icons.call_rounded,
          ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.of(context).textPrimary,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final colors = AppColors.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
