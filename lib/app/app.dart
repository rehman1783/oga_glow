import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/theme/app_theme.dart';
import 'package:oga_glow/app/routes/app_pages.dart';
import 'package:oga_glow/app/routes/app_routes.dart';

import 'bindings/initial_binding.dart';
import '../core/theme/theme_controller.dart';

class OgaGlowApp extends StatelessWidget {
  const OgaGlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        final themeController = Get.put(ThemeController(), permanent: true);

        return Obx(
          () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OGA Glow',

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.themeMode.value,

            initialBinding: InitialBinding(),
            initialRoute: AppRoutes.splash,
            getPages: AppPages.pages,
          ),
        );
      },
    );
  }
}
