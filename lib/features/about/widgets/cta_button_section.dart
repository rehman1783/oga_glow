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
    required this.onShopNow,
    required this.onContactUs,
    required this.onTalkToExperts,
    required this.onViewProducts,
    this.onPhone,
    this.onEmail,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final effectiveLeftButton = (leftButtonTitle != null && leftButtonTitle!.trim().isNotEmpty)
        ? leftButtonTitle!
        : AboutConstants.shopNowLabel;

    final effectiveRightButton = (rightButtonTitle != null && rightButtonTitle!.trim().isNotEmpty)
        ? rightButtonTitle!
        : AboutConstants.contactUsLabel;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.primaryLight.withValues(alpha: 0.05),
            colors.cardBackground,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section heading
          Text(
            AboutConstants.ctaTitle,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            AboutConstants.ctaSubtitle,
            style: AppTextStyles.body.copyWith(
              fontSize: 13.sp,
              color: colors.textSecondary,
              height: 1.4,
            ),
          ),
          SizedBox(height: 18.h),

          // Primary Action Grid (Shop Now, Contact Us, Talk to Experts, View Products)
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              _CTAButton(
                icon: Icons.shopping_bag_rounded,
                label: effectiveLeftButton,
                color: AppColors.primary,
                onTap: onShopNow,
              ),
              _CTAButton(
                icon: Icons.headset_mic_rounded,
                label: effectiveRightButton,
                color: AppColors.primary,
                onTap: onContactUs,
              ),
              _CTAButton(
                icon: Icons.chat_rounded,
                label: AboutConstants.talkToExpertsLabel,
                color: const Color(0xFF25D366), // WhatsApp Green Accent
                onTap: onTalkToExperts,
              ),
              _CTAButton(
                icon: Icons.grid_view_rounded,
                label: AboutConstants.viewProductsLabel,
                color: AppColors.primaryLight,
                onTap: onViewProducts,
              ),
            ],
          ),
          SizedBox(height: 18.h),

          // Quick Support Links Divider
          Row(
            children: [
              Expanded(child: Divider(color: colors.border.withValues(alpha: 0.6))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  'DIRECT SUPPORT',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: colors.textSecondary,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Expanded(child: Divider(color: colors.border.withValues(alpha: 0.6))),
            ],
          ),
          SizedBox(height: 14.h),

          // Quick Phone & Email launcher buttons
          Row(
            children: [
              Expanded(
                child: _QuickSupportButton(
                  icon: Icons.phone_in_talk_rounded,
                  label: 'Call Helpline',
                  color: AppColors.primary,
                  onTap: onPhone ?? onTalkToExperts,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _QuickSupportButton(
                  icon: Icons.email_rounded,
                  label: 'Email Support',
                  color: AppColors.primaryLight,
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

/// A single CTA button with modern styling.
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withValues(alpha: 0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17.sp,
              color: AppColors.white,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.button.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Quick support contact launcher tile.
class _QuickSupportButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickSupportButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return BounceTap(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16.sp, color: color),
            SizedBox(width: 8.w),
            Text(
              label,
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
  }
}
