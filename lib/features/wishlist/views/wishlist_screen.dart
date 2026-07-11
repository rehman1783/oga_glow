import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/wishlist_controller.dart';
import '../widgets/empty_wishlist.dart';
import '../widgets/wishlist_item_card.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final WishlistController controller = Get.find<WishlistController>(
    tag: WishlistController.tag,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(92.h),
        child: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          // leading: IconButton(
          //   onPressed: () => Get.back(),
          //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
          // ),
          title: Center(child: Text('Wishlist', style: AppTextStyles.heading2)),
        ),
      ),
      body:
          // Obx(
          //   () => Container(
          //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          //     decoration: BoxDecoration(
          //       color: AppColors.secondary,
          //       borderRadius: BorderRadius.circular(999.r),
          //       border: Border.all(color: AppColors.border.withOpacity(0.8)),
          //     ),
          //     child: Text(
          //       '${controller.wishlistItems.length} item${controller.wishlistItems.length == 1 ? '' : 's'}',
          //       style: AppTextStyles.caption,
          //     ),
          //   ),
          // ),
          Obx(() {
            if (controller.wishlistItems.isEmpty) {
              return const EmptyWishlist();
            }

            return ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
              itemCount: controller.wishlistItems.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
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
