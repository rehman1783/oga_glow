import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';

import '../../../core/theme/app_text_styles.dart';
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
          Row(
            children: [
              Text(
                "Categories",
                style: AppTextStyles.heading2,
              ),

              const Spacer(),

             TextButton(
  onPressed: () {
    Get.toNamed(AppRoutes.category);
  },
  child: const Text("See All"),
),
            ],
          ),

          SizedBox(height: 20.h),

          SizedBox(
            height: 110.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemBuilder: (context, index) {
                final category = controller.categories[index];

                return CategoryItem(
                  icon: category['icon'] as IconData,
                  title: category['name'] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}