import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import 'package:oga_glow/features/home/models/brand_features_model.dart';

class BrandFeaturesSection extends GetView<HomeController> {
  const BrandFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Obx(() {
      if (controller.isBrandFeaturesLoading.value) {
        return _buildLoadingState(context, colors);
      }

      if (controller.hasBrandFeaturesError.value) {
        return _buildErrorState(context, colors);
      }

      final brandFeatures = controller.brandFeatures.value;
      if (brandFeatures == null ||
          (brandFeatures.info.isEmpty &&
              brandFeatures.card1.isEmpty &&
              brandFeatures.card2.isEmpty &&
              brandFeatures.card3.isEmpty &&
              brandFeatures.card4.isEmpty)) {
        return const SizedBox.shrink();
      }

      final intro = brandFeatures.info.isNotEmpty
          ? brandFeatures.info.first
          : null;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: colors.panel,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: colors.border.withValues(alpha: 0.25)),
          boxShadow: [
            BoxShadow(
              color: colors.border.withValues(alpha: 0.16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (intro != null) ...[
              Text(
                intro.mainHeading ?? 'Crafted with purpose',
                style: AppTextStyles.heading2.copyWith(
                  color: colors.textPrimary,
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                intro.para ?? '',
                style: AppTextStyles.body.copyWith(
                  color: colors.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.h),
            ],
            _buildCardRow(
              context,
              brandFeatures.card1,
              icons: [Icons.auto_awesome],
            ),
            if (brandFeatures.card2.isNotEmpty) SizedBox(height: 12.h),
            _buildCardRow(
              context,
              brandFeatures.card2,
              icons: [Icons.eco_rounded],
            ),
            if (brandFeatures.card3.isNotEmpty) SizedBox(height: 12.h),
            _buildCardRow(
              context,
              brandFeatures.card3,
              icons: [Icons.recycling_rounded],
            ),
            if (brandFeatures.card4.isNotEmpty) ...[
              SizedBox(height: 12.h),
              _buildCard4(context, brandFeatures.card4.first),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildLoadingState(BuildContext context, AppThemeColors colors) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: colors.panel,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 18.h, width: 180.w, color: colors.border),
          SizedBox(height: 10.h),
          Container(height: 12.h, width: double.infinity, color: colors.border),
          SizedBox(height: 8.h),
          Container(height: 12.h, width: 220.w, color: colors.border),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: List.generate(
              3,
              (index) => Container(
                width: 150.w,
                height: 96.h,
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, AppThemeColors colors) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: colors.panel,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: colors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 28.sp,
            color: AppColors.error,
          ),
          SizedBox(height: 8.h),
          Text(
            controller.brandFeaturesErrorMessage.value.isNotEmpty
                ? controller.brandFeaturesErrorMessage.value
                : 'Unable to load brand features right now.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 12.h),
          TextButton.icon(
            onPressed: () => controller.fetchBrandFeatures(),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildCardRow(
    BuildContext context,
    List<FeatureCardModel> cards, {
    required List<IconData> icons,
  }) {
    if (cards.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: cards.map((card) {
        return SizedBox(
          width: 0.92.sw - 32.w,
          child: _buildFeatureCard(context, card, icons.first),
        );
      }).toList(),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    FeatureCardModel card,
    IconData icon,
  ) {
    final colors = AppColors.of(context);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: colors.border.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  card.title ?? 'Feature',
                  style: AppTextStyles.heading2.copyWith(
                    color: colors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  card.description ?? '',
                  style: AppTextStyles.body.copyWith(
                    color: colors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard4(BuildContext context, Card4Model card) {
    final colors = AppColors.of(context);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: colors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.title ?? 'A calm ritual in a noisy world',
            style: AppTextStyles.heading2.copyWith(
              color: colors.textPrimary,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            card.description ?? '',
            style: AppTextStyles.body.copyWith(
              color: colors.textSecondary,
              height: 1.45,
            ),
          ),
          if (card.bulletPoints.isNotEmpty) ...[
            SizedBox(height: 10.h),
            ...card.bulletPoints.map(
              (point) => Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 16.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        point,
                        style: AppTextStyles.body.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
