import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/services/services.dart';

class MessageController extends GetxController {
  final RxString contactName = RxString('');
  final RxString contactNumber = RxString('');
  RxInt urgencyRatingValue = 1.obs;
  late final FirestoreService firestoreService;
  late final NotificationService notificationService;
  final RxBool isServiceOn = RxBool(false);
  final RxBool doesUserExists = RxBool(false);

  MessageController() {
    firestoreService = FirestoreService();
    notificationService = NotificationService();
  }

  void initialiseInformation() async {
    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['contact'] != null) {
      final Contact contact = arguments['contact'];
      contactName.value = contact.displayName;
      contactNumber.value =
          contact.phones.isNotEmpty ? contact.phones.first.number : '';
    }
    doesUserExists.value =
        await firestoreService.checkIfUserExists(contactNumber.value);
    isServiceOn.value =
        await firestoreService.checkIfServiceOn(contactNumber.value);
    if (kDebugMode) {
      print(contactName.value);
      print(contactNumber.value);
    }
  }

  void sendMessage(String message) async {
    try {
      if (isServiceOn.value) {
        String? fcmToken =
            await firestoreService.getFCMToken(contactNumber.value);

        if (fcmToken != null) {
          await notificationService.sendMessage(
              fcmToken, message, getUrgencyStatus(urgencyRatingValue.value));
        } else {
          print(
              'FCM token is null for the contact number: ${contactNumber.value}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending message: $e');
      }
    }
  }

  String getUrgencyStatus(int rating) {
    return rating == 1
        ? 'Low'
        : rating == 2
            ? 'Medium'
            : 'High';
  }

  @override
  void onInit() {
    super.onInit();
    initialiseInformation();
  }
}
