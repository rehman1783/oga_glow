import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_item_card.dart';

import '../widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.find<CartController>(
    tag: CartController.tag,
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
          title: Center(child: Text('Cart', style: AppTextStyles.heading2)),
          scrolledUnderElevation: 0,
        ),
      ),
      body: Obx(() {
        final items = cartController.cartItems;

        if (items.isEmpty) {
          return const EmptyCart();
        }

        final total = items.fold<int>(0, (sum, item) {
          final p = int.tryParse(item['price']?.toString() ?? '') ?? 0;
          return sum + p;
        });

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return CartItemCard(product: items[index], index: index);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.border.withOpacity(0.8)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Total', style: AppTextStyles.caption),
                        const Spacer(),
                        Text('Rs. $total', style: AppTextStyles.heading2),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.toNamed('/checkout');
                        },
                        icon: const Icon(Icons.payment_rounded),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        label: Text('Checkout', style: AppTextStyles.button),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
