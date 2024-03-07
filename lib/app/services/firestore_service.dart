import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(String userId, String name) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'name': name});
      print('User data saved successfully: $name, userId: $userId');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  Future<void> updateUserFCMToken(String fcmToken) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    await _firestore.collection('users').doc(userId).update({
      'fcmToken': fcmToken,
    }).then((value) {
      print("FCM Updated ${fcmToken}");
    });
  }
}
