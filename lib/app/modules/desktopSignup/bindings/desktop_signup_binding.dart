import 'package:get/get.dart';

import '../controllers/desktop_signup_controller.dart';

class DesktopSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesktopSignupController>(
      () => DesktopSignupController(),
    );
  }
}
