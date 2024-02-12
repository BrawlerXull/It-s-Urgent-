// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';

class VerifyController extends GetxController {
  RxString pin = "".obs;
  void verifyOtp() async {
    try {
      if (Get.arguments != null && Get.arguments['verificationId'] != null) {
        final String verificationId = Get.arguments['verificationId'];
        final String name = Get.arguments['name'];

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: pin.value,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        await saveUserData(userCredential.user!.uid, name);
        Get.toNamed(Routes.HOME);
      } else {
        print('Verification ID not found');
      }
    } catch (e) {
      print('Error during OTP verification and sign-in: $e');
    }
  }

  final count = 0.obs;

  void increment() => count.value++;

  Future<void> saveUserData(String userId, String name) async {
    try {
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'name': name,
        });
        // print("User data saved successfully" + name + userId);
    } catch (e) {
        print('Error saving user data: $e');
    }
}

}
