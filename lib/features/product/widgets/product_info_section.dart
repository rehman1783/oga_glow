import 'package:flutter/material.dart';

class ProductInfoSection extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfoSection({
    super.key,
    required this.product,
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
            product['name'],
            style:
                const TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Rs ${product['price']}",
          ),

          const SizedBox(height: 10),

          Text(
            product['category'],
          ),
        ],
      ),
    );
  }
}