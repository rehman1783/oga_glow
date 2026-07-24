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
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).cardBackground,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.of(context).border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Icon(
              Icons.person_rounded,
              size: 38.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  email,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
                if (joinedDate != null && joinedDate!.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Joined: $joinedDate',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                SizedBox(
                  height: 32.h,
                  child: BounceTap(
                    onTap: onEdit ?? () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      decoration: BoxDecoration(
                        color: AppColors.of(context).cardBackground,

                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 14.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Edit',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
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
