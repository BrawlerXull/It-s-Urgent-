import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

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
}
