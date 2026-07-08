import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';
import 'package:oga_glow/features/home/widgets/home_app_bar.dart';
import 'package:oga_glow/features/home/widgets/home_banner_slider.dart';
import 'package:oga_glow/features/home/widgets/home_search_bar.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
  child: SingleChildScrollView(
    child: Column(
      children: [
        HomeAppBar(),

        SizedBox(height: 20.h),

        HomeSearchBar(),

        SizedBox(height: 24.h),

        HomeBannerSlider(),
      ],
    ),
  ),
),
    );
  }
}