import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/app_theme.dart';
import 'package:oga_glow/core/routes/app_pages.dart';
import 'package:oga_glow/core/routes/app_routes.dart';

import 'bindings/initial_binding.dart';

class OgaGlowApp extends StatelessWidget {
  const OgaGlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OGA Glow',

          theme: AppTheme.lightTheme,

          initialBinding: InitialBinding(),

          initialRoute: AppRoutes.splash,

          getPages: AppPages.pages,
        );
      },
    );
  }
}
