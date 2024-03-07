// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';
import 'package:itsurgent/app/services/services.dart';

class VerifyController extends GetxController {
  RxString pin = ''.obs;
  late final AuthenticationService authenticationService;
  late final FirestoreService firestoreService;

  VerifyController() {
    authenticationService = AuthenticationService();
    firestoreService = FirestoreService();
  }

  void verifyOtp() async {
    UserCredential userCredential =
        await authenticationService.verifyOtp(Get.arguments, pin.value);
    firestoreService.saveUserData(
        userCredential.user!.uid, Get.arguments['name']);
    Get.toNamed(Routes.HOME);
  }
}
