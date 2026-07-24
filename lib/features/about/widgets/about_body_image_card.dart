import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';

/// Reusable network image widget with CachedNetworkImage,
/// loading indicator, error widget, and theme awareness.
class AboutBodyImageCard extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const AboutBodyImageCard({
    super.key,
    required this.imageUrl,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final double effectiveHeight = height ?? 200.h;

    return Container(
      width: double.infinity,
      height: effectiveHeight,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.of(context).cardBackground,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: fit,
          width: double.infinity,
          height: effectiveHeight,
          placeholder: (context, url) => Container(
            color: AppColors.of(context).cardBackground,
            child: Center(
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: AppColors.of(context).cardBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.broken_image_rounded,
                  size: 40.sp,
                  color: AppColors.of(context).textSecondary,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Failed to load image',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
