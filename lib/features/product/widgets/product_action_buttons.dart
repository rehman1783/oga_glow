import 'package:flutter/material.dart';

class ProductActionButtons
    extends StatelessWidget {
  const ProductActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Add To Cart',
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Buy Now',
              ),
            ),
          ),
        ],
      ),
    );
  }
}