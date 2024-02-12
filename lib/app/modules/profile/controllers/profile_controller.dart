
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserService _userService = UserService();

  final name = ''.obs;
  final email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final userData = await _userService.getUserData();
      name.value = userData['name'] ?? 'Please Update the Name';
      email.value = userData['email'] ?? 'Please Update the Email';
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData(String newName, String newEmail) async {
    try {
      await _userService.updateUserData(newName, newEmail);
      name.value = newName;
      email.value = newEmail;
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}


class UserService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getUserData() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    final userSnapshot = await _firestore.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      return userSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception('User document does not exist.');
    }
  }

  Future<void> updateUserData(String newName, String newEmail) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in.');
    }
    await _firestore.collection('users').doc(userId).update({
      'name': newName,
      'email': newEmail,
    });
  }
}
