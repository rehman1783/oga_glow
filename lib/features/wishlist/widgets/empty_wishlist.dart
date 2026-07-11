import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100.sp,
          ),

          SizedBox(height: 20.h),

          const Text(
            "Your Wishlist is Empty",
          ),

          SizedBox(height: 10.h),

          const Text(
            "Save products you love and they will appear here.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}