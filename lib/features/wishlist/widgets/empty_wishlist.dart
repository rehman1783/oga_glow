import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_empty_state.dart';
import '../../main_navigation/controllers/main_navigation_controller.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomEmptyState(
      icon: Icons.favorite_border_rounded,
      title: 'Your Wishlist is Empty',
      description: 'Save items you love so you can quickly find and buy them later.',
      buttonText: 'Discover Products',
      onButtonPressed: () {
        if (Get.isRegistered<MainNavigationController>()) {
          Get.find<MainNavigationController>().changeIndex(1);
        }
      },
    );
  }
}
