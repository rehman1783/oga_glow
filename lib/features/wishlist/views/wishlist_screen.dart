import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/wishlist_controller.dart';
import '../widgets/empty_wishlist.dart';
import '../widgets/wishlist_item_card.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final WishlistController controller =
      Get.find<WishlistController>(
    tag: WishlistController.tag,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
        ),
      ),

      body: Obx(() {
        if (controller.wishlistItems.isEmpty) {
          return const EmptyWishlist();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.wishlistItems.length,
          itemBuilder: (context, index) {
            return WishlistItemCard(
              product: controller.wishlistItems[index],
              index: index,
            );
          },
        );
      }),
    );
  }
}