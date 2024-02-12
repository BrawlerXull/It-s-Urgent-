
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';

class VerifyController extends GetxController {
  RxString pin = ''.obs;

  void verifyOtp() async {
    try {
      final arguments = Get.arguments;
      if (arguments == null || arguments['verificationId'] == null) {
        print('Verification ID not found');
        return;
      }
      final String verificationId = arguments['verificationId'];
      final String name = arguments['name'];
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: pin.value,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await saveUserData(userCredential.user!.uid, name);
      Get.toNamed(Routes.HOME);
      print('User logged in successfully: $name');
    } catch (e) {
      print('Error during OTP verification and sign-in: $e');
    }
  }

  Future<void> saveUserData(String userId, String name) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'name': name});
      print('User data saved successfully: $name, userId: $userId');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }
}