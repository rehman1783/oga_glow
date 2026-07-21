import 'package:get/get.dart';
import '../controllers/about_controller.dart';

/// Binding for the About Us feature.
///
/// Registers [AboutController] lazily so it is available
/// when the About Us screen is opened.
class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
  }
}

