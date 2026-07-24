import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionTitle({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.of(context).textPrimary,
          ),
        ),

        const Spacer(),

        TextButton(onPressed: onSeeAll, child: const Text("See All")),
      ],
    );
  }
}
