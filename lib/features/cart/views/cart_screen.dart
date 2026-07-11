import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Glow Serum',
      'category': 'Skincare',
      'price': '799',
      'image': 'assets/images/banner1.jpeg',
    },
    {
      'name': 'Herbal Moisturizer',
      'category': 'Moisturizer',
      'price': '599',
      'image': 'assets/images/banner2.jpeg',
    },
  ];

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
      body: Builder(
        builder: (context) {
          final items = cartItems;

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
                    return CartItemCard(product: items[index]);
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
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.8),
                    ),
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
                            Get.snackbar(
                              'Checkout',
                              'Checkout flow will be wired later.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.cardBackground,
                              colorText: AppColors.textPrimary,
                              borderRadius: 14.r,
                            );
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
        },
      ),
    );
  }
}
