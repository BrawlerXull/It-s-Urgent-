// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(
      String userId, String name, String phoneNumber) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'service': true,
        'phoneNumber': phoneNumber,
        'urgencyStatus': 1
      });
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  Future<void> updateUserFCMToken(String fcmToken) async {
    final userId = _getCurrentUserId();
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
    final userId = _getCurrentUserId();
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

  Future<void> updateUserData(
      String newName, String newEmail, int urgencyStatus, bool service) async {
    final userId = _getCurrentUserId();
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': newName,
        'email': newEmail,
        'urgencyStatus': urgencyStatus,
        'service': service
      });
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }

  String _getCurrentUserId() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    return userId;
  }

  Future<bool> checkIfServiceOn(String phoneNumber) async {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final userDocument = querySnapshot.docs.first;
        final bool isServiceOn = userDocument['service'];
        print('Service status for $phoneNumber: $isServiceOn');
        return isServiceOn;
      } else {
        print('User not found for phone number: $phoneNumber');
      }
    } catch (e) {
      print('Error checking service status: $e');
      rethrow;
    }
    return false;
  }

  Future<bool> checkIfUserExists(String phoneNumber) async {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }

  Future<String?> getFCMToken(String phoneNumber) async {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final userDocument = querySnapshot.docs.first;
        final fcmToken = userDocument['fcmToken'] as String?;
        if (fcmToken != null) {
          return fcmToken;
        } else {
          print('FCM token not found for phone number: $phoneNumber');
          return null;
        }
      } else {
        print('User not found for phone number: $phoneNumber');
        return null;
      }
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  Future<int?> getUrgencyStatus(String phoneNumber) async {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDocument = querySnapshot.docs.first;
        return userDocument['urgencyStatus'] as int?;
      } else {
        print('User not found for phone number: $phoneNumber');
        return null;
      }
    } catch (e) {
      print('Error getting urgency status: $e');
      return null;
    }
  }
}
