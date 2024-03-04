import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';

class HomeController extends GetxController {
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
    try {
      await FirebaseAuth.instance.signOut();
      Get.toNamed(Routes.SIGNUP);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      criticalAlert: true,
      badge: true,
      sound: true,
      provisional: true,
      carPlay: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User gave permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User gave provisinal permission");
    } else {
      print("User denied the permission");
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<void> updateUserData(String fcmToken) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    await _firestore.collection('users').doc(userId).update({
      'fcmToken': fcmToken,
    }).then((value) {
      print("FCM Updated");
    });
  }

  @override
  void onInit() {
    super.onInit();
    requestNotificationPermission();
    getDeviceToken().then((value) {
      print("Device Token");
      print(value);
      updateUserData(value);
    });
    fetchContacts();
  }
}
