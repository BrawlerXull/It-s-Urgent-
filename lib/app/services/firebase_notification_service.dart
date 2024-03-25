// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseNotificaionService {
  late final FirebaseMessaging _messaging;

  FirebaseNotificaionService() {
    _messaging = FirebaseMessaging.instance;
    _initializeFirebaseMessaging();
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

  Future<void> sendMessage(String fcmToken, String message, String urgencyStatus) async {
    var data = {
      'to': fcmToken,
      'notification': {'title': message, 'body': urgencyStatus, "sound": "notification.mp3"},
      'android': {
        'notification': {
          'notification_count': 23,
        },
      },
      'data': {
        'urgencyStatus': urgencyStatus,
      }
    };

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAApLqgVsQ:APA91bF2hltZy2Bt-erUciMOUQCzyoYbkS2EkFSgAFhYQb_1BTvtEqVV1tfnrJAa0GtqSaANZVFhdzoAgvmUMpKGL7ycCDqr0jU4Webv1DoSmiKQ2DffgnbuQwJIsCL1Y5enF-YnoTPf'
        },
      );
      print('Message sent to FCM token: $fcmToken');
    } catch (e) {
      print('Error sending FCM message: $e');
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
}
