import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../widgets/category_chip.dart';

class CategoryChipRow extends StatefulWidget {
  final CategoryController controller;

  const CategoryChipRow({super.key, required this.controller});

  @override
  State<CategoryChipRow> createState() => _CategoryChipRowState();
}

class _CategoryChipRowState extends State<CategoryChipRow> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categories = widget.controller.categories;
      final selected = widget.controller.selectedCategory.value;
      final selectedIndex = categories.indexWhere((c) => c == selected);

      // After the frame is drawn, auto-scroll the selected chip into view.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (selectedIndex < 0) return;

        // Each chip has approx width. This is an estimate; we just need to ensure visibility.
        const double approxChipWidth = 90;
        const double rightPadding = 10;

        final double target = (selectedIndex * approxChipWidth) - rightPadding;
        final clamped = target.clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );

        // Only animate if we are meaningfully away from the target.
        if ((_scrollController.offset - clamped).abs() > 10) {
          _scrollController.animateTo(
            clamped,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        }
      });

      return ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryChip(
            title: category,
            isSelected: selected == category,
            onTap: () => widget.controller.changeCategory(category),
          );
        },
      );
    });
  }
}
