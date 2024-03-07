import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';
import 'package:itsurgent/app/services/firebase_authentication_service.dart';
import 'package:itsurgent/app/services/firestore_service.dart';
import 'package:itsurgent/app/services/notification_service.dart';

class HomeController extends GetxController {
  late final AuthenticationService authenticationService;
  late final NotificationService notificationService;
  late final FirestoreService firestoreService;
  HomeController() {
    authenticationService = AuthenticationService();
    notificationService = NotificationService();
    firestoreService = FirestoreService();
  }
  RxList<Contact>? contacts = <Contact>[].obs;
  RxBool permissionDenied = false.obs;

  Future<void> fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      permissionDenied.value = true;
    } else {
      var fetchedContacts = await FlutterContacts.getContacts();
      contacts = fetchedContacts.obs;
      for (int i = 0; i < contacts!.length; i++) {
        contacts![i] = (await FlutterContacts.getContact(contacts![i].id))!;
      }
    }
    update();
  }

  Future<void> signOut() async {
    authenticationService.signOut();
    Get.toNamed(Routes.SIGNUP);
  }

  Future<String> getDeviceToken() async {
    return notificationService.getDeviceToken();
  }

  Future<void> updateUserFCMToken(String fcmToken) async {
    firestoreService.updateUserFCMToken(fcmToken);
  }

  @override
  void onInit() {
    super.onInit();
    getDeviceToken().then((value) {
      updateUserFCMToken(value);
    });
    fetchContacts();
  }
}
