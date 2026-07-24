import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oga_glow/core/theme/app_colors.dart';
import 'package:oga_glow/core/theme/app_text_styles.dart';

/// A premium statistic card with animated counting effect.
///
/// Displays a [value], [suffix], [label], and an [icon] with
/// a gradient accent bar at the bottom.
class StatisticCard extends StatefulWidget {
  /// The numeric value to display.
  final int value;

  /// Suffix text (e.g., "+", "K").
  final String suffix;

  /// Label describing the statistic (e.g., "Happy Customers").
  final String label;

  /// Icon name string mapping to Material Icons.
  final String iconName;

  const StatisticCard({
    super.key,
    required this.value,
    required this.suffix,
    required this.label,
    required this.iconName,
  });

  @override
  State<StatisticCard> createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  int _displayValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _animation.addListener(() {
      setState(() {
        _displayValue = (_animation.value * widget.value).round();
      });
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getIcon() {
    switch (widget.iconName) {
      case 'favorite':
        return Icons.favorite_rounded;
      case 'inventory_2':
        return Icons.inventory_2_rounded;
      case 'calendar_today':
        return Icons.calendar_today_rounded;
      case 'check_circle':
        return Icons.check_circle_rounded;
      default:
        return Icons.business_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).cardBackground,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.of(context).border),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.1),
                  AppColors.primaryLight.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(_getIcon(), size: 22.sp, color: AppColors.primary),
          ),
          SizedBox(height: 12.h),

          // Animated value
          Text(
            '$_displayValue${widget.suffix}',
            style: AppTextStyles.heading1.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 4.h),

          // Label
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              fontSize: 12.sp,
              color: AppColors.of(context).textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
