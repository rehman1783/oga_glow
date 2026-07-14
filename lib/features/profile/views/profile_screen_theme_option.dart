import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ProfileThemeModeOption extends StatelessWidget {
  final String title;
  final ThemeMode value;
  final ThemeMode groupValue;
  final ValueChanged<ThemeMode> onSelected;

  const ProfileThemeModeOption({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onSelected,
  });

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return BounceLikeTile(
      isSelected: _isSelected,
      title: title,
      onTap: () => onSelected(value),
    );
  }
}

class BounceLikeTile extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTap;

  const BounceLikeTile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.14)
              : AppColors.primary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withOpacity(0.35)
                : AppColors.border.withOpacity(0.35),
          ),
        ),
        child: Icon(
          isSelected ? Icons.check_rounded : Icons.circle_outlined,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: 18.sp,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.heading2.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        size: 20.sp,
        color: AppColors.textSecondary.withOpacity(isSelected ? 1 : 0.75),
      ),
    );
  }
}
