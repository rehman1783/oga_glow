import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/wishlist/widgets/empty_wishlist.dart';

import '../controllers/wishlist_controller.dart';
import '../widgets/wishlist_item_card.dart';

class WishlistScreen
    extends GetView<WishlistController> {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wishlist",
        ),
      ),

      body: Obx(
        () {
          if (controller
              .wishlistItems.isEmpty) {
            return const EmptyWishlist();
          }

          return ListView.builder(
            padding:
                const EdgeInsets.all(16),
            itemCount:
                controller.wishlistItems.length,
            itemBuilder: (context, index) {
              return WishlistItemCard(
                product: controller
                    .wishlistItems[index],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}