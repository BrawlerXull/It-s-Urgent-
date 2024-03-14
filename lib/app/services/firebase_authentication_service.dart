// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signUp(String name, String phoneNumber) async {
    late String verificationId;
    late int? resendToken;

    await _auth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credentials) {},
      verificationFailed: (FirebaseAuthException ex) {
        print(ex);
      },
      codeSent: (String verId, int? token) {
        verificationId = verId;
        resendToken = token;
        print("${verificationId}SendOtp");
      },
      codeAutoRetrievalTimeout: (String verId) {},
      phoneNumber: phoneNumber,
    );

    return {
      'verificationId': verificationId,
      'resendToken': resendToken,
    };
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
