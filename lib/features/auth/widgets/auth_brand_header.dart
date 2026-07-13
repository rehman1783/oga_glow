import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AuthBrandHeader extends StatelessWidget {
  const AuthBrandHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome back! Please login to continue.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}

