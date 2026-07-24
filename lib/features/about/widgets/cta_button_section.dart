import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/core/widgets/bounce_tap.dart';

/// Call-to-action button section for the About Us screen.
///
/// Displays multiple CTA buttons (Shop Now, Contact Us, etc.)
/// with modern styling, icons, and proper responsive sizing.
class CTAButtonSection extends StatelessWidget {
  /// Callback for "Shop Now" button.
  final VoidCallback onShopNow;

  /// Callback for "Contact Us" button.
  final VoidCallback onContactUs;

  /// Callback for "Talk to Experts" button.
  final VoidCallback onTalkToExperts;

  /// Callback for "View Products" button.
  final VoidCallback onViewProducts;

  const CTAButtonSection({
    super.key,
    required this.onShopNow,
    required this.onContactUs,
    required this.onTalkToExperts,
    required this.onViewProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.10),
            AppColors.primaryLight.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section heading
          Text(
            AboutConstants.ctaTitle,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AboutConstants.ctaSubtitle,
            style: AppTextStyles.body.copyWith(
              fontSize: 13.sp,
              color: AppColors.of(context).textSecondary,
              height: 1.4,
            ),
          ),
          SizedBox(height: 20.h),

          // CTA Buttons in a responsive grid
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              _CTAButton(
                icon: Icons.shopping_bag_rounded,
                label: AboutConstants.shopNowLabel,
                color: AppColors.primary,
                onTap: onShopNow,
              ),
              _CTAButton(
                icon: Icons.headset_mic_rounded,
                label: AboutConstants.contactUsLabel,
                color: AppColors.primary,
                onTap: onContactUs,
              ),
              _CTAButton(
                icon: Icons.chat_rounded,
                label: AboutConstants.talkToExpertsLabel,
                color: AppColors.primary,
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
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: AppColors.white,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.button.copyWith(
                fontSize: 13.sp,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

