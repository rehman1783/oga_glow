import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/bounce_tap.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';

class ContactInfoSection extends StatelessWidget {
  final ContactInfoModel? contactInfo;
  final Function(String) onPhoneTap;
  final Function(String) onEmailTap;
  final Function(String) onUrlTap;
  final Function(String phone)? onWhatsAppNumberTap;
  final VoidCallback? onWhatsAppTap;
  final Function(String text, String label)? onCopyTap;

  const ContactInfoSection({
    super.key,
    required this.contactInfo,
    required this.onPhoneTap,
    required this.onEmailTap,
    required this.onUrlTap,
    this.onWhatsAppNumberTap,
    this.onWhatsAppTap,
    this.onCopyTap,
  });

  @override
  Widget build(BuildContext context) {
    final info = contactInfo ?? ContactInfoModel.fallback();
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -------------------------------------------------------------
        // 1. Quick Direct Communication Action Row
        // -------------------------------------------------------------
        Row(
          children: [
            Expanded(
              child: _buildQuickActionButton(
                context,
                title: 'Call Support',
                subtitle: 'Direct Helpline',
                icon: Icons.phone_in_talk_rounded,
                accentColor: AppColors.primary,
                onTap: () => onPhoneTap(info.primaryPhone),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildQuickActionButton(
                context,
                title: 'WhatsApp',
                subtitle: 'Instant Chat',
                icon: Icons.chat_rounded,
                accentColor: const Color(0xFF25D366),
                onTap: () {
                  if (onWhatsAppTap != null) {
                    onWhatsAppTap!();
                  } else {
                    onUrlTap(info.effectiveWhatsAppUrl);
                  }
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildQuickActionButton(
                context,
                title: 'Email Us',
                subtitle: 'Send Mail',
                icon: Icons.mail_outline_rounded,
                accentColor: AppColors.accent,
                onTap: () => onEmailTap(info.primaryEmail),
              ),
            ),
          ],
        ),

        SizedBox(height: 24.h),

        // -------------------------------------------------------------
        // 2. Structured Direct Channels
        // -------------------------------------------------------------
        _buildSectionHeader(
          context,
          title: 'Direct Support Channels',
          icon: Icons.support_agent_rounded,
        ),
        SizedBox(height: 12.h),

        // A. Phone Helplines Container Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: colors.border.withValues(alpha: 0.7)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
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
                      Icons.phone_rounded,
                      color: AppColors.primary,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone & Helpline Support',
                          style: AppTextStyles.body.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          'Tap call icon to dial directly',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 11.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              const Divider(height: 1),
              SizedBox(height: 12.h),
              ...info.structuredPhones.map((phoneItem) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: colors.panelSecondary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colors.border.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    phoneItem.label,
                                    style: AppTextStyles.caption.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  if (phoneItem.badge != null) ...[
                                    SizedBox(width: 6.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.w, vertical: 2.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        phoneItem.badge!,
                                        style: AppTextStyles.caption.copyWith(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                phoneItem.number,
                                style: AppTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: colors.textPrimary,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Quick Action Icon Buttons
                        if (phoneItem.hasWhatsApp)
                          IconButton(
                            icon: const Icon(Icons.chat_rounded),
                            color: const Color(0xFF25D366),
                            iconSize: 20.sp,
                            tooltip: 'Chat on WhatsApp',
                            onPressed: () {
                              if (onWhatsAppNumberTap != null) {
                                onWhatsAppNumberTap!(phoneItem.number);
                              } else if (onWhatsAppTap != null) {
                                onWhatsAppTap!();
                              } else {
                                onUrlTap('https://wa.me/${phoneItem.number.replaceAll(RegExp(r'[^0-9]'), '')}');
                              }
                            },
                          ),
                        IconButton(
                          icon: const Icon(Icons.call_rounded),
                          color: AppColors.primary,
                          iconSize: 20.sp,
                          tooltip: 'Call Phone',
                          onPressed: () => onPhoneTap(phoneItem.number),
                        ),
                        if (onCopyTap != null)
                          IconButton(
                            icon: const Icon(Icons.copy_rounded),
                            color: colors.textSecondary,
                            iconSize: 18.sp,
                            tooltip: 'Copy Number',
                            onPressed: () => onCopyTap!(phoneItem.number, phoneItem.label),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 14.h),

        // B. Email Support Container Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: colors.border.withValues(alpha: 0.7)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
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
                      color: AppColors.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.mail_outline_rounded,
                      color: AppColors.accent,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email & Written Inquiries',
                          style: AppTextStyles.body.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          'Formal correspondence & order queries',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 11.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              const Divider(height: 1),
              SizedBox(height: 12.h),
              ...info.structuredEmails.map((emailItem) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: colors.panelSecondary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colors.border.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                emailItem.label,
                                style: AppTextStyles.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                  color: AppColors.accent,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                emailItem.email,
                                style: AppTextStyles.body.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send_rounded),
                          color: AppColors.accent,
                          iconSize: 20.sp,
                          tooltip: 'Send Email',
                          onPressed: () => onEmailTap(emailItem.email),
                        ),
                        if (onCopyTap != null)
                          IconButton(
                            icon: const Icon(Icons.copy_rounded),
                            color: colors.textSecondary,
                            iconSize: 18.sp,
                            tooltip: 'Copy Email',
                            onPressed: () => onCopyTap!(emailItem.email, emailItem.label),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 14.h),

        // C. Working Hours & Availability Banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: AppColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Operational Working Hours',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      info.workingHours,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Open Now',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // -------------------------------------------------------------
        // 3. Office Locations
        // -------------------------------------------------------------
        _buildSectionHeader(
          context,
          title: 'Office Locations',
          icon: Icons.business_rounded,
        ),
        SizedBox(height: 12.h),
        ...info.allOffices.map((office) {
          final isHead = office == info.headOffice ||
              (office.title != null && office.title!.toLowerCase().contains('head'));
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: isHead
                      ? AppColors.primary.withValues(alpha: 0.3)
                      : colors.border.withValues(alpha: 0.6),
                  width: isHead ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
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
                          color: isHead
                              ? AppColors.primary.withValues(alpha: 0.12)
                              : colors.panelSecondary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          isHead ? Icons.location_city_rounded : Icons.apartment_rounded,
                          color: isHead ? AppColors.primary : colors.textPrimary,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              office.title ?? (isHead ? 'Head Office' : 'Branch Office'),
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: colors.textPrimary,
                              ),
                            ),
                            if (office.city != null && office.city!.isNotEmpty)
                              Text(
                                office.city!,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (isHead)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Main HQ',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        size: 16.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          office.address ?? 'Address unavailable',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 13.sp,
                            color: colors.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),

        SizedBox(height: 20.h),

        // -------------------------------------------------------------
        // 4. Social Connectivity
        // -------------------------------------------------------------
        if (info.socialLinks.isNotEmpty) ...[
          _buildSectionHeader(
            context,
            title: 'Social & Connectivity',
            icon: Icons.public_rounded,
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: info.socialLinks.map((link) {
              final linkData = _detectSocialMeta(link);
              return BounceTap(
                onTap: () => onUrlTap(link),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: colors.border.withValues(alpha: 0.7)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        linkData.icon,
                        size: 16.sp,
                        color: linkData.color,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        linkData.title,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.of(context).textPrimary,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    final colors = AppColors.of(context);
    return BounceTap(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: accentColor.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accentColor, size: 20.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                fontSize: 9.sp,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _SocialMeta _detectSocialMeta(String link) {
    final lower = link.toLowerCase();
    if (lower.contains('wa.me') || lower.contains('whatsapp')) {
      return _SocialMeta('WhatsApp', Icons.chat_rounded, const Color(0xFF25D366));
    }
    if (lower.contains('facebook')) {
      return _SocialMeta('Facebook', Icons.facebook_rounded, const Color(0xFF1877F2));
    }
    if (lower.contains('instagram')) {
      return _SocialMeta('Instagram', Icons.camera_alt_rounded, const Color(0xFFE4405F));
    }
    if (lower.contains('linkedin')) {
      return _SocialMeta('LinkedIn', Icons.work_rounded, const Color(0xFF0A66C2));
    }
    if (lower.contains('youtube')) {
      return _SocialMeta('YouTube', Icons.play_circle_fill_rounded, const Color(0xFFFF0000));
    }
    return _SocialMeta('Official Website', Icons.language_rounded, AppColors.primary);
  }
}

class _SocialMeta {
  final String title;
  final IconData icon;
  final Color color;

  const _SocialMeta(this.title, this.icon, this.color);
}


