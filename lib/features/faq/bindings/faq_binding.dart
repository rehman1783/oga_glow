import 'package:get/get.dart';
import '../controllers/faq_controller.dart';

/// Binding for the FAQ feature.
///
/// Registers [FaqController] lazily so it is available
/// when the FAQ screen is opened.
class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqController>(() => FaqController());
  }
}

