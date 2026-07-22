import 'package:get/get.dart';
import '../controllers/legal_controller.dart';

/// Binding for the Legal & Compliance feature.
///
/// Registers [LegalController] lazily so it is available
/// when the Legal & Compliance screen is opened.
class LegalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LegalController>(() => LegalController());
  }
}
