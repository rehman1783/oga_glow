import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_empty_state.dart';
import '../../main_navigation/controllers/main_navigation_controller.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomEmptyState(
      icon: Icons.shopping_cart_outlined,
      title: 'Your Cart is Empty',
      description: 'Explore our skincare and beauty collections to discover products tailored for you.',
      buttonText: 'Start Shopping',
      onButtonPressed: () {
        if (Get.isRegistered<MainNavigationController>()) {
          Get.find<MainNavigationController>().changeIndex(0);
        }
      },
    );
  }
}
