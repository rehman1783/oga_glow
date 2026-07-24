import 'package:get/get.dart';
import 'package:oga_glow/features/about/controllers/about_controller.dart';
import 'package:oga_glow/features/about/repositories/about_repository.dart';
import 'package:oga_glow/features/about/services/about_service.dart';

/// Binding for the About Us feature.
///
/// Registers [AboutService], [AboutRepository], and [AboutController] lazily.
class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutService>(() => AboutService());
    Get.lazyPut<AboutRepository>(
      () => AboutRepository(aboutService: Get.find<AboutService>()),
    );
    Get.lazyPut<AboutController>(
      () => AboutController(repository: Get.find<AboutRepository>()),
    );
  }
}
