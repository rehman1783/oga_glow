import 'package:flutter/material.dart';
import 'package:oga_glow/core/theme/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
  label: Text(
    title,
    style: TextStyle(
      color: isSelected
          ? AppColors.white
          : AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    ),
  ),
  selected: isSelected,
  selectedColor: AppColors.primary,
  backgroundColor: AppColors.white,
  showCheckmark: false,
  side: BorderSide(
    color: isSelected
        ? AppColors.primary
        : AppColors.border,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  onSelected: (_) => onTap(),
)
    );
  }
}
