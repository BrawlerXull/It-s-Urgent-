// ignore_for_file: avoid_print

import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  late final FirebaseMessaging _messaging;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage remoteMessage) async {
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
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage remoteMessage) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var darwinInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }
}
