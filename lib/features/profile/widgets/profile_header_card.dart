import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/bounce_tap.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String? joinedDate;
  final VoidCallback? onEdit;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    this.joinedDate,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'O';

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.8),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 68.r,
            height: 68.r,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: AppTextStyles.heading1.copyWith(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'VIP',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  email,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    color: colors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (joinedDate != null && joinedDate!.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Member since: $joinedDate',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10.5.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                BounceTap(
                  scaleBound: 0.92,
                  onTap: onEdit ?? () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: colors.panelSecondary,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 13.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Edit Profile',
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 11.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
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
