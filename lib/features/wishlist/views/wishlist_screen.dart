import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/wishlist_controller.dart';
import '../widgets/empty_wishlist.dart';
import '../widgets/wishlist_item_card.dart';
import '../../../core/widgets/fade_slide_transition.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final WishlistController controller = Get.find<WishlistController>(
    tag: WishlistController.tag,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.h),
        child: AppBar(
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: 
          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu_book_sharp),
          ),
          title: Text(
            'Wishlist',
            style: AppTextStyles.heading2.copyWith(
              fontSize: 18,
              color: AppColors.of(context).textPrimary,
            ),
          ),
          scrolledUnderElevation: 0,
        ),
      ),
      body: Obx(() {
        if (controller.wishlistItems.isEmpty) {
          return const EmptyWishlist();
        }

        return ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
          itemCount: controller.wishlistItems.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return FadeSlideTransition(
              index: index,
              child: WishlistItemCard(
                product: controller.wishlistItems[index],
                index: index,
              ),
            );
          },
        );
      }),
    );
  }
}
