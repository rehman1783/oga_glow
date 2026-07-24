import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ProductBenefitsSection extends StatelessWidget {
  const ProductBenefitsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: AppColors.of(context).textPrimary,
    );
    final itemStyle = TextStyle(
      color: AppColors.of(context).textSecondary,
      height: 1.6,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Benefits', style: titleStyle),
          const SizedBox(height: 10),
          Text('✔ Deep Cleansing', style: itemStyle),
          Text('✔ Natural Ingredients', style: itemStyle),
          Text('✔ Hydrating Formula', style: itemStyle),
        ],
      ),
    );
  }
}