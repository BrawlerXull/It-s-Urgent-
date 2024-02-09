// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:itsurgent/app/routes/app_pages.dart';

class VerifyController extends GetxController {
  RxString pin = "".obs;
  void verifyOtp() async {
  try {
    if (Get.arguments != null && Get.arguments['verificationId'] != null) {
      final String verificationId = Get.arguments['verificationId'];
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: pin.value,
      );
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        Get.toNamed(Routes.HOME);
      });
    } else {
      print('Verification ID not found');
    }
  } catch (e) {
    print(e);
  }
}


  final count = 0.obs;

  void increment() => count.value++;
}
