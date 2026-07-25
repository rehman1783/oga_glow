import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/features/category/controllers/category_controller.dart';
import 'package:oga_glow/features/main_navigation/controllers/main_navigation_controller.dart';

import '../controllers/home_controller.dart';
import 'category_item.dart';

class HomeCategories extends GetView<HomeController> {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          SizedBox(
            height: 110.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              separatorBuilder: (context, index) => SizedBox(width: 16.w),
              itemBuilder: (context, index) {
                final category = controller.categories[index];

                return CategoryItem(
                  icon: category['icon'] as IconData,
                  title: category['name'] as String,
                  onTap: () {
                    final catKey = category['name'] as String;

                    if (Get.isRegistered<CategoryController>()) {
                      Get.find<CategoryController>().openCategory(catKey);
                    }

                    if (Get.isRegistered<MainNavigationController>()) {
                      Get.find<MainNavigationController>().changeIndex(1);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
