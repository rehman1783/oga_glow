import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/wishlist/controllers/wishlist_controller.dart';

class ProductInfoSection extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Route args from ProductCard may include only: name, price, image.
    final name = (product['name'] ?? '').toString();
    final priceText = (product['price'] ?? '').toString();
    final category = product['category']?.toString();
    final description = product['description']?.toString();

    final theme = Theme.of(context);
    final hasCategory = (category ?? '').trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Builder(
                builder: (context) {
                  return Obx(() {
                    final wishlistController = Get.find<WishlistController>(
                      tag: WishlistController.tag,
                    );

                    final productData = {
                      'name': product['name'],
                      'price': product['price'],
                      'image': product['image'],
                      'category': product['category'],
                      'description': product['description'],
                    };

                    final inWishlist = wishlistController.isInWishlist(
                      productData,
                    );

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        wishlistController.toggleWishlistItem(productData);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          inWishlist
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: inWishlist ? Colors.red : null,
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(Icons.star, size: 18, color: Colors.amber),
              const SizedBox(width: 6),
              const Text('4.8'),
              const SizedBox(width: 10),
              Text(
                '• ${hasCategory ? category : 'Premium'}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'Rs $priceText',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (hasCategory)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                category!,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          if (hasCategory) const SizedBox(height: 12),

          // Mini interactive toggle: show more/less description.
          _DescriptionBlurb(description: description),
        ],
      ),
    );
  }
}

class _DescriptionBlurb extends StatefulWidget {
  final String? description;

  const _DescriptionBlurb({this.description});

  @override
  State<_DescriptionBlurb> createState() => _DescriptionBlurbState();
}

class _DescriptionBlurbState extends State<_DescriptionBlurb> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final raw = (widget.description ?? '').trim();
    if (raw.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final maxLines = expanded ? null : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          raw,
          maxLines: maxLines,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => expanded = !expanded),
            icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
            label: Text(expanded ? 'Less' : 'More'),
          ),
        ),
      ],
    );
  }
}
