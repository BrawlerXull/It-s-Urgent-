import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';
import 'package:itsurgent/app/services/services.dart';

class MessageController extends GetxController {
  final RxString contactName = RxString('');
  final RxString contactNumber = RxString('');
  RxInt urgencyRatingValue = 1.obs;
  late final FirestoreService firestoreService;
  late final FirebaseNotificaionService firebaseNotificaionService;
  final RxBool isUrgencyServiceOn = RxBool(false);
  final RxBool doesUserExists = RxBool(false);

  MessageController() {
    firestoreService = FirestoreService();
    firebaseNotificaionService = FirebaseNotificaionService();
  }

  void initialiseInformation() async {
    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['contact'] != null) {
      final Contact contact = arguments['contact'];
      contactName.value = contact.displayName;
      contactNumber.value = contact.phones.isNotEmpty ? contact.phones.first.number : '';
    }
    doesUserExists.value = await firestoreService.checkIfUserExists(contactNumber.value);
    isUrgencyServiceOn.value = await firestoreService.checkIfServiceOn(contactNumber.value);
    if (kDebugMode) {
      print(contactName.value);
      print(contactNumber.value);
    }
  }

  void sendMessage(String message) async {
    try {
      if (isUrgencyServiceOn.value) {
        String? fcmToken = await firestoreService.getFCMToken(contactNumber.value);
        if (fcmToken != null) {
          int? urgencyStatus = await firestoreService.getUrgencyStatus(contactNumber.value);
          if (urgencyStatus != null && urgencyStatus <= urgencyRatingValue.value) {
            bool isPinServiceOn = await firestoreService.checkIfPinServiceOn(contactNumber.value);

            if (isPinServiceOn) {
              Get.toNamed(Routes.PIN, arguments: {
                'message': message,
                'phoneNumber': contactNumber.value,
                'fcmToken': fcmToken,
                'urgencyStatus': getUrgencyStatusFromRating(urgencyRatingValue.value),
              });
            } else {
              await firebaseNotificaionService.sendMessage(
                  fcmToken, message, getUrgencyStatusFromRating(urgencyRatingValue.value));
              Get.snackbar('Done !', 'The notification has be successfully sent');
            }
          } else {
            Get.snackbar('Error !', 'User is in more urgent meeting.');
            print("Urgency too low to send notification.");
          }
        } else {
          print('FCM token is null for the contact number: ${contactNumber.value}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending message: $e');
      }
    }
  }

  String getUrgencyStatusFromRating(int rating) {
    return rating == 1
        ? 'Low'
        : rating == 2
            ? 'Medium'
            : 'High';
  }

  void addToBlockList() async {
    // await firestoreService.addToBlockList(contactNumber.value);
  }

  @override
  void onInit() {
    super.onInit();
    initialiseInformation();
  }
}
