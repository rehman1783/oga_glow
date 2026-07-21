import 'package:get/get.dart';
import '../controllers/contact_controller.dart';

/// Binding for the Contact Us feature.
///
/// Registers [ContactController] lazily so it is available
/// when the Contact Us screen is opened.
class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
