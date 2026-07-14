import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionTitle({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.heading2),

        const Spacer(),

        TextButton(onPressed: onSeeAll, child: Text("See All")),
      ],
    );
  }
}
