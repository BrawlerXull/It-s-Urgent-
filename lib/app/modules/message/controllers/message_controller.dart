import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final RxString contactName = RxString('');
  final RxString contactNumber = RxString('');

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

  @override
  void onInit() {
    super.onInit();
    initialiseInformation();
  }
}
