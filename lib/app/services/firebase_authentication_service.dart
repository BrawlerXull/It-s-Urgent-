// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signUp(String name, String phoneNumber) async {
    await _auth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credentials) {},
        verificationFailed: (FirebaseAuthException ex) {
          print(ex);
        },
        codeSent: (String verificationId, int? resendToken) {
          print("$verificationId SendOtp");
          Get.toNamed(Routes.VERIFY, arguments: {
            'verificationId': verificationId,
            'resendToken': resendToken,
            'name': name
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: phoneNumber);
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<UserCredential> verifyOtp(dynamic arguments, String pin) async {
    try {
      if (arguments == null || arguments['verificationId'] == null) {
        throw Exception('Verification ID not found');
      }

      final String verificationId = arguments['verificationId'];

      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: pin,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print('Error during OTP verification and sign-in: $e');
      throw e;
    }
  }
}
