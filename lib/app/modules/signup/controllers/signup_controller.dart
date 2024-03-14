// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';
import 'package:itsurgent/app/services/services.dart';

class SignupController extends GetxController {
  RxString phoneNumber = "".obs;
  RxString name = "".obs;

  late final AuthenticationService authenticationService;
  SignupController() {
    authenticationService = AuthenticationService();
  }

  void sendOtp() async {
    try {
      final data =
          await authenticationService.signUp(name.value, phoneNumber.value);
      Get.toNamed(Routes.VERIFY, arguments: {
        'verificationId': data['verificationId'],
        'resendToken': data['resendToken'],
        'name': name.value,
      });
    } catch (e) {
      print('Error sending otp : $e');
    }
  }
}
