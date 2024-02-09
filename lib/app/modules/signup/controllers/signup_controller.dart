import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';

class SignupController extends GetxController {
  RxString phoneNumber = "".obs;
  RxString name = "".obs;
  RxString verificationId = "".obs;
  RxString resendToken = "".obs;

  void sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credentials) {},
        verificationFailed: (FirebaseAuthException ex) {
          print(ex);
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          this.resendToken.value = resendToken?.toString() ??
              ""; // Convert resendToken to string and handle null
          print(verificationId + "SendOtp");
          Get.toNamed(Routes.VERIFY, arguments: {
            'verificationId': verificationId,
            'resendToken': resendToken,
            'name' : name.value
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: phoneNumber.value);
  }

  final count = 0.obs;

  void increment() => count.value++;
}
