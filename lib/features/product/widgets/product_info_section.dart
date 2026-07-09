import 'package:flutter/material.dart';

class ProductInfoSection extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Route args from ProductCard only include: name, price, image.
    // Make this section resilient to missing keys to avoid crashes when navigating.
    final name = (product['name'] ?? '').toString();
    final price = product['price'];
    final priceText = price == null ? '' : price.toString();
    final category = product['category']?.toString() ?? '';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text('Rs $priceText'),

          const SizedBox(height: 10),

          if (category.isNotEmpty) Text(category),
        ],
      ),
    );
  }
}
