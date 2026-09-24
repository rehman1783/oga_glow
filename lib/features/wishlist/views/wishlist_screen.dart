import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/fade_slide_transition.dart';
import '../../drawer/widgets/app_drawer.dart';
import '../controllers/wishlist_controller.dart';
import '../widgets/empty_wishlist.dart';
import '../widgets/wishlist_item_card.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  final WishlistController controller = Get.find<WishlistController>(
    tag: WishlistController.tag,
  );

  void _showClearConfirmation(BuildContext context) {
    final colors = AppColors.of(context);
    Get.dialog(
      AlertDialog(
        backgroundColor: colors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Clear Wishlist?',
          style: AppTextStyles.heading2.copyWith(
            color: colors.textPrimary,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          'Are you sure you want to remove all items from your wishlist?',
          style: AppTextStyles.body.copyWith(
            color: colors.textSecondary,
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextStyles.button.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pureRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () {
              Get.back();
              controller.clearWishlist();
            },
            child: Text(
              'Clear All',
              style: AppTextStyles.button.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.h),
        child: AppBar(
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.sort_rounded, color: colors.textPrimary),
          ),
          title: Text(
            'Wishlist',
            style: AppTextStyles.heading2.copyWith(
              fontSize: 18.sp,
              color: colors.textPrimary,
            ),
          ),
          actions: [
            Obx(() {
              if (controller.wishlistItems.isEmpty) return const SizedBox.shrink();
              return IconButton(
                onPressed: () => _showClearConfirmation(context),
                tooltip: 'Clear Wishlist',
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.pureRed,
                  size: 22.sp,
                ),
              );
            }),
          ],
          scrolledUnderElevation: 0,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.wishlistItems.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeWidth: 3.r,
            ),
          );
        }

        if (controller.wishlistItems.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => controller.fetchWishlist(forceRefresh: true),
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const EmptyWishlist(),
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchWishlist(forceRefresh: true),
          color: AppColors.primary,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
            itemCount: controller.wishlistItems.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              return FadeSlideTransition(
                index: index,
                child: WishlistItemCard(
                  product: controller.wishlistItems[index],
                  index: index,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
