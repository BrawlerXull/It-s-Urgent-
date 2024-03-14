// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  late final FirebaseMessaging _messaging;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    _messaging = FirebaseMessaging.instance;
    _initializeFirebaseMessaging();
    _initializeLocalNotifications();
  }

  Future<void> _initializeFirebaseMessaging() async {
    try {
      await _messaging.requestPermission(
        alert: true,
        announcement: true,
        criticalAlert: true,
        badge: true,
        sound: true,
        provisional: true,
        carPlay: true,
      );
      print("Permission granted for Firebase Messaging");
    } catch (e) {
      print("Error requesting permission for Firebase Messaging: $e");
    }
  }

  Future<void> _initializeLocalNotifications() async {
    try {
      var androidInitializationSettings =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var darwinInitializationSettings = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload) {},
      );
      print("Local notifications initialized");
    } catch (e) {
      print("Error initializing local notifications: $e");
    }
  }

  Future<String> getDeviceToken() async {
    try {
      final token = await _messaging.getToken();
      return token!;
    } catch (e) {
      print("Error getting device token: $e");
      throw e;
    }
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage remoteMessage) async {
    try {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification',
        importance: Importance.max,
      );
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription: "Channel Description",
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher",
      );

      DarwinNotificationDetails darwinNotificationDetails =
          const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          34,
          remoteMessage.notification!.title.toString(),
          remoteMessage.notification!.body.toString(),
          notificationDetails,
        );
      });
    } catch (e) {
      print("Error showing notification: $e");
    }
  }
}
