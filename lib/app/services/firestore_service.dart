// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(String userId, String name) async {
    try {
      await _firestore.collection('users').doc(userId).set({'name': name});
    } catch (e) {
      print('Error saving user data: $e');
      rethrow; 
    }
  }

  Future<void> updateUserFCMToken(String fcmToken) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    try {
      await _firestore.collection('users').doc(userId).update({
        'fcmToken': fcmToken,
      });
      print("FCM Updated $fcmToken");
    } catch (e) {
      print('Error updating FCM token: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    try {
      final userSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception('User document does not exist.');
      }
    } catch (e) {
      print('Error getting user data: $e');
      rethrow;
    }
  }

  Future<void> updateUserData(String newName, String newEmail) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': newName,
        'email': newEmail,
      });
    } catch (e) {
      print('Error updating user data: $e');
      rethrow; 
    }
  }
}
