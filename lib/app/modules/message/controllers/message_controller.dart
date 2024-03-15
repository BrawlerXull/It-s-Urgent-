import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/services/services.dart';

class MessageController extends GetxController {
  final RxString contactName = RxString('');
  final RxString contactNumber = RxString('');
  RxInt urgencyRatingValue = 1.obs;
  late final FirestoreService firestoreService;

  MessageController() {
    firestoreService = FirestoreService();
  }

  void initialiseInformation() {
    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['contact'] != null) {
      final Contact contact = arguments['contact'];
      contactName.value = contact.displayName;
      contactNumber.value =
          contact.phones.isNotEmpty ? contact.phones.first.number : '';
    }
    if (kDebugMode) {
      print(contactName.value);
      print(contactNumber.value);
    }
  }

  void sendMessage() {
    firestoreService.sendMessage(contactNumber.value);
  }

  @override
  void onInit() {
    super.onInit();
    initialiseInformation();
  }
}
