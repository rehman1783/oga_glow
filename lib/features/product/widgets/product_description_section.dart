import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ProductDescriptionSection
    extends StatelessWidget {
  final String description;

  const ProductDescriptionSection({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.of(context).textPrimary,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: TextStyle(
              color: AppColors.of(context).textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}