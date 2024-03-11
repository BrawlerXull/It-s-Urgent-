// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  late final FirebaseMessaging _messaging;
  NotificationService() {
    _messaging = FirebaseMessaging.instance;
    requestPermission();
  }

  Future<void> requestPermission() async {
    final settings = await _messaging.requestPermission(
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
      print("User gave provisional permission");
    } else {
      print("User denied the permission");
    }
  }

  Future<String> getDeviceToken() async {
    final token = await _messaging.getToken();
    return token!;
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
    });
  }
}
