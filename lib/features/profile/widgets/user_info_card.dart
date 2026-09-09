import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/bounce_tap.dart';
import '../../auth/models/user_model.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel? user;
  final bool isLoggedIn;

  const UserInfoCard({
    super.key,
    required this.user,
    required this.isLoggedIn,
  });

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    Widget? trailing,
  }) {
    final colors = AppColors.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              size: 18.sp,
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
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: colors.textSecondary,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: AppTextStyles.body.copyWith(
                    color: colors.textPrimary,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    if (!isLoggedIn || user == null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: colors.border.withValues(alpha: 0.8),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
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
                Icon(
                  Icons.account_circle_outlined,
                  size: 20.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Account Information',
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Sign in with your registered account to view your profile details, personal information, and order history.',
              style: AppTextStyles.body.copyWith(
                fontSize: 12.5.sp,
                color: colors.textSecondary,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16.h),
            BounceTap(
              onTap: () => Get.toNamed(AppRoutes.login),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Sign In / Register',
                  style: AppTextStyles.button.copyWith(
                    color: Colors.white,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final displayName = user!.name.isNotEmpty ? user!.name : 'OGA Customer';
    final displayEmail = user!.email.isNotEmpty ? user!.email : 'No email address';
    final registrationDate = user!.createdAt != null && user!.createdAt!.isNotEmpty
        ? DateFormatter.formatFullDate(user!.createdAt)
        : 'Registered';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.8),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.badge_outlined,
                    size: 20.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Account Information',
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 12.sp,
                      color: const Color(0xFF2E7D32),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Verified',
                      style: TextStyle(
                        color: const Color(0xFF2E7D32),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(color: colors.border.withValues(alpha: 0.5)),
          _buildInfoRow(
            context: context,
            icon: Icons.person_outline_rounded,
            label: 'Full Name',
            value: displayName,
          ),
          Divider(color: colors.border.withValues(alpha: 0.5)),
          _buildInfoRow(
            context: context,
            icon: Icons.email_outlined,
            label: 'Email Address',
            value: displayEmail,
          ),
          if (registrationDate.isNotEmpty) ...[
            Divider(color: colors.border.withValues(alpha: 0.5)),
            _buildInfoRow(
              context: context,
              icon: Icons.calendar_today_outlined,
              label: 'Member Since',
              value: registrationDate,
            ),
          ],
        ],
      ),
    );
  }
}
