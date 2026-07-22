import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';

/// Controller for the Legal & Compliance module.
///
/// Provides navigation actions for the individual policy screens.
class LegalController extends GetxController {
  /// Navigate to Terms of Service screen.
  void openTermsOfService() {
    Get.toNamed(AppRoutes.termsOfService);
  }

  /// Navigate to Privacy Policy screen.
  void openPrivacyPolicy() {
    Get.toNamed(AppRoutes.privacyPolicy);
  }

  /// Navigate to Return & Refund Policy screen.
  void openReturnRefundPolicy() {
    Get.toNamed(AppRoutes.returnRefundPolicy);
  }
}

