import 'package:flutter/material.dart';

class ProductBenefitsSection
    extends StatelessWidget {
  const ProductBenefitsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:
          EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text('Benefits'),

          SizedBox(height: 10),

          Text(
              '✔ Deep Cleansing'),
          Text(
              '✔ Natural Ingredients'),
          Text(
              '✔ Hydrating Formula'),
        ],
      ),
    );
  }
}