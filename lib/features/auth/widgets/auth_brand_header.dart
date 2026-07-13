import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBrandHeader extends StatelessWidget {
  const AuthBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      width: double.infinity,
      child: Image.asset(
        'assets/images/auth_pattern.png',
        fit: BoxFit.cover,
      ),
    );
  }
}