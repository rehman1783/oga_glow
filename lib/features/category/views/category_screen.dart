import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_text_styles.dart';
import '../controllers/category_controller.dart';
import '../widgets/category_card.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: AppTextStyles.heading2,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: GridView.builder(
          itemCount: controller.categories.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            return CategoryCard(
              icon: category['icon'] as IconData,
              title: category['name'] as String,
              onTap: () {
                // Product screen pr navigate karwayenge
              },
            );
          },
        ),
      ),
    );
  }
}