import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentBanner = 0.obs;

  final banners = [
    'assets/images/banner1.jpeg',
    'assets/images/banner2.jpeg',
    'assets/images/banner3.jpeg',
  ];

  void updateBanner(int index) {
    currentBanner.value = index;
  }
}
