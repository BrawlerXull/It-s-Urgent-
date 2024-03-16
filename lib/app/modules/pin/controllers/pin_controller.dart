import 'package:get/get.dart';
import 'package:itsurgent/app/services/services.dart';

class PinController extends GetxController {
  RxString pin = ''.obs;
  late final FirestoreService firestoreService;
  late final FirebaseNotificaionService firebaseNotificaionService;

  PinController() {
    firestoreService = FirestoreService();
    firebaseNotificaionService = FirebaseNotificaionService();
  }

  void verifyPin() async {
    final String phoneNumber = Get.arguments['phoneNumber'];
    final String fcmToken = Get.arguments['fcmToken'];
    final String message = Get.arguments['message'];
    final String urgencyStatus = Get.arguments['urgencyStatus'];
    final String? storedPin = await firestoreService.getPin(phoneNumber);
    if (storedPin != null && storedPin == pin.value) {
      await firebaseNotificaionService.sendMessage(fcmToken, message, urgencyStatus);
      Get.snackbar('Done !', 'The notification has be successfully sent');
      print('PIN verified successfully');
    } else {
      print('Incorrect PIN or PIN not found');
    }
  }
}
