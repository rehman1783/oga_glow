import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String? joinedDate;
  final VoidCallback? onEdit;
  final bool isGuest;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    this.joinedDate,
    this.onEdit,
    this.isGuest = false,
  });

  String _getInitials(String fullName) {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return 'O';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length > 1 && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return trimmed[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final initial = isGuest ? 'G' : _getInitials(name);
    final formattedJoined = joinedDate != null && joinedDate!.isNotEmpty
        ? (DateTime.tryParse(joinedDate!) != null
            ? 'Member since ${_monthYear(DateTime.parse(joinedDate!))}'
            : 'Member since: $joinedDate')
        : null;

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
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              gradient: isGuest
                  ? LinearGradient(
                      colors: [
                        colors.panelSecondary,
                        colors.border,
                      ],
                    )
                  : const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              shape: BoxShape.circle,
              boxShadow: isGuest
                  ? []
                  : [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.28),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: AppTextStyles.heading1.copyWith(
                color: isGuest ? colors.textPrimary : Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        isGuest ? 'Guest Account' : name,
                        style: AppTextStyles.heading2.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!isGuest)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'ACTIVE',
                          style: TextStyle(
                            color: const Color(0xFF2E7D32),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  isGuest ? 'Sign in to access all features' : email,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    color: colors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!isGuest && formattedJoined != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    formattedJoined,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10.5.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _monthYear(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final m = (date.month >= 1 && date.month <= 12) ? months[date.month - 1] : '';
    return '$m ${date.year}';
  }
}
