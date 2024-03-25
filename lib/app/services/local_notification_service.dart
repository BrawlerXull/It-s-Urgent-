import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  playSound();
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
}

void playSound() async {
  final player = AudioPlayer();
  await player.play(
      AssetSource(
        'notification.mp3',
      ),
      volume: 1);
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  LocalNotificationService() {
    _initializeLocalNotifications();
  }

  Future<void> _initializeLocalNotifications() async {
    try {
      var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
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

  Future<void> showNotification(RemoteMessage remoteMessage) async {
    try {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification',
        importance: Importance.max,
      );
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription: "Channel Description",
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher",
      );

      DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
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

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) async {
      print(message.notification!.title.toString());
      showNotification(message);
      playSound();
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
