import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import 'category_screen.dart';

/// Dedicated route for "All Products" as requested.
/// Uses the same UI as CategoryScreen, but forces selectedCategory = 'All'.
class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller exists (CategoryBinding registers it).
    final controller = Get.find<CategoryController>();
    controller.selectedCategory.value = 'All';

    return const CategoryScreen();
  }
}
