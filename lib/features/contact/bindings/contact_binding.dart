import 'package:get/get.dart';
import 'package:oga_glow/features/contact/controllers/contact_controller.dart';
import 'package:oga_glow/features/contact/repositories/contact_repository.dart';
import 'package:oga_glow/features/contact/services/contact_service.dart';

/// Binding for the Contact Us feature.
///
/// Registers [ContactController] lazily so it is available
/// when the Contact Us screen is opened.
class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactService>(() => ContactService());
    Get.lazyPut<ContactRepository>(
      () => ContactRepository(service: Get.find<ContactService>()),
    );
    Get.lazyPut<ContactController>(
      () => ContactController(repository: Get.find<ContactRepository>()),
    );
  }
}
