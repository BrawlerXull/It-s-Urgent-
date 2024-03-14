// ignore_for_file: avoid_print

import 'package:get/get.dart';
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
      authenticationService.signUp(name.value, phoneNumber.value);
    } catch (e) {
      print('Error sending otp : $e');
    }
  }
}
