import 'package:flutter/material.dart';

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
          const Text(
            'Description',
          ),

          const SizedBox(height: 10),

          Text(description),
        ],
      ),
    );
  }
}