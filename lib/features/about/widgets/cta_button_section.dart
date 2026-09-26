import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/bounce_tap.dart';

/// Call-to-action button section for the About Us screen.
///
/// Displays CTA buttons with dynamic API button labels and direct support launcher buttons.
class CTAButtonSection extends StatelessWidget {
  /// Dynamic title for the left button (from banner.leftButton)
  final String? leftButtonTitle;

  /// Dynamic title for the right button (from banner.rightButton)
  final String? rightButtonTitle;

  /// Live Phone Number from API
  final String? phone;

  /// Live Email Address from API
  final String? email;

  /// Callback for Left Button / "Shop Now" button.
  final VoidCallback onShopNow;

  /// Callback for Right Button / "Contact Us" button.
  final VoidCallback onContactUs;

  /// Callback for "Talk to Experts" button.
  final VoidCallback onTalkToExperts;

  /// Callback for "View Products" button.
  final VoidCallback onViewProducts;

  /// Callback for Phone Call launcher button.
  final VoidCallback? onPhone;

  /// Callback for Email launcher button.
  final VoidCallback? onEmail;

  const CTAButtonSection({
    super.key,
    this.leftButtonTitle,
    this.rightButtonTitle,
    this.phone,
    this.email,
    required this.onShopNow,
    required this.onContactUs,
    required this.onTalkToExperts,
    required this.onViewProducts,
    this.onPhone,
    this.onEmail,
  });

  /// Sanitizes dynamic button labels (filters out junk API responses like "ssss")
  static String _cleanLabel(String? raw, String fallback) {
    if (raw == null) return fallback;
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return fallback;
    if (RegExp(r'^(.)\1+$').hasMatch(trimmed) && trimmed.length > 2) {
      return fallback;
    }
    return trimmed;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final effectiveLeftButton = _cleanLabel(leftButtonTitle, AboutConstants.shopNowLabel);
    final effectiveRightButton = _cleanLabel(rightButtonTitle, AboutConstants.contactUsLabel);
    final displayPhone = (phone != null && phone!.trim().isNotEmpty) ? phone!.trim() : '+92 321 3270507';
    final displayEmail = (email != null && email!.trim().isNotEmpty) ? email!.trim() : 'support@ogaglow.com';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.14),
            AppColors.primaryLight.withValues(alpha: 0.06),
            colors.cardBackground,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.headset_mic_rounded, size: 12.sp, color: AppColors.primary),
                SizedBox(width: 6.w),
                Text(
                  'FAST & DIRECT SUPPORT',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          // Section Title & Subtitle
          Text(
            AboutConstants.ctaTitle,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            AboutConstants.ctaSubtitle,
            style: AppTextStyles.body.copyWith(
              fontSize: 12.5.sp,
              color: colors.textSecondary,
              height: 1.4,
            ),
          ),
          SizedBox(height: 18.h),

          // Primary Actions Grid (2x2 equal width grid)
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _CTAButton(
                      icon: Icons.shopping_bag_rounded,
                      label: effectiveLeftButton,
                      color: AppColors.primary,
                      onTap: onShopNow,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _CTAButton(
                      icon: Icons.support_agent_rounded,
                      label: effectiveRightButton,
                      color: AppColors.primary,
                      onTap: onContactUs,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _CTAButton(
                      icon: Icons.chat_rounded,
                      label: AboutConstants.talkToExpertsLabel,
                      color: const Color(0xFF25D366), // WhatsApp Green Accent
                      onTap: onTalkToExperts,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _CTAButton(
                      icon: Icons.grid_view_rounded,
                      label: AboutConstants.viewProductsLabel,
                      color: AppColors.primaryLight,
                      onTap: onViewProducts,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Direct Support Channel Divider
          Row(
            children: [
              Expanded(child: Divider(color: colors.border.withValues(alpha: 0.5))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  'DIRECT CONTACT API',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: colors.textSecondary,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Expanded(child: Divider(color: colors.border.withValues(alpha: 0.5))),
            ],
          ),
          SizedBox(height: 14.h),

          // Direct Contact Channels (Call & Email Cards with Live API Response Data)
          Row(
            children: [
              Expanded(
                child: _DirectContactCard(
                  icon: Icons.phone_in_talk_rounded,
                  title: 'Call Helpline',
                  subtitle: displayPhone,
                  accentColor: AppColors.primary,
                  onTap: onPhone ?? onTalkToExperts,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _DirectContactCard(
                  icon: Icons.mark_email_read_rounded,
                  title: 'Email Support',
                  subtitle: displayEmail,
                  accentColor: const Color(0xFF0284C7), // Sky Blue Accent
                  onTap: onEmail ?? onContactUs,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A single CTA button with modern gradient styling.
class _CTAButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CTAButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withValues(alpha: 0.88),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: AppColors.white,
            ),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.button.copyWith(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Direct Contact Launcher Tile displaying live API phone & email.
class _DirectContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;

  const _DirectContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return BounceTap(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, size: 16.sp, color: accentColor),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
