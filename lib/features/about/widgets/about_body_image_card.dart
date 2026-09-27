import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/widgets/custom_network_image.dart';

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
    this.height = 250,
    this.fit = BoxFit.cover,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final double effectiveHeight = (height ?? 250).h;

    return GestureDetector(
      onTap: () => _showImagePreviewDialog(context, imageUrl!),
      child: Container(
        width: double.infinity,
        height: effectiveHeight,
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.of(context).cardBackground,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius.r),
              child: CustomNetworkImage(
                imageUrl: imageUrl!,
                fit: fit,
                width: double.infinity,
                height: effectiveHeight,
                placeholder: (context, url) => Container(
                  height: effectiveHeight,
                  color: AppColors.of(context).cardBackground,
                  child: Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: effectiveHeight,
                  color: AppColors.of(context).cardBackground,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_rounded,
                        size: 28.sp,
                        color: AppColors.of(context).textSecondary,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Failed to load image',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.of(context).textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.fullscreen_rounded,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePreviewDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(16.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              minScale: 0.8,
              maxScale: 4.0,
              child: CustomNetworkImage(
                imageUrl: url,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close_rounded, color: Colors.white),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
