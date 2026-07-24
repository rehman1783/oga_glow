import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/constants/about_constants.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// Hero / Header section for the About Us screen.
///
/// Displays banner image, heading, and banner paragraph from API.
class AboutHeader extends StatelessWidget {
  final String? imageUrl;
  final String? paragraph;
  final String? title;

  const AboutHeader({
    super.key,
    this.imageUrl,
    this.paragraph,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTitle = title ?? AboutConstants.heroTitle;
    final effectiveParagraph = (paragraph != null && paragraph!.trim().isNotEmpty)
        ? paragraph!
        : AboutConstants.heroSubtitle;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.primaryLight.withValues(alpha: 0.05),
            AppColors.of(context).panelSecondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Banner Image (using CachedNetworkImage) or default logo icon
          if (imageUrl != null && imageUrl!.trim().isNotEmpty) ...[
            Container(
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Container(
                    color: AppColors.of(context).cardBackground,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => _buildLogoCircle(context),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ] else ...[
            _buildLogoCircle(context),
            SizedBox(height: 20.h),
          ],

          // Heading
          Text(
            effectiveTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.of(context).textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12.h),

          // Paragraph / Subtitle
          Text(
            effectiveParagraph,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              color: AppColors.of(context).textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoCircle(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        color: AppColors.of(context).cardBackground,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(
        Icons.spa_rounded,
        size: 34.sp,
        color: AppColors.primary,
      ),
    );
  }
}
