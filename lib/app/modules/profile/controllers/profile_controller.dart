import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  final count = 0.obs;
  RxString name = "".obs;
  RxString email = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          name.value = userData['name'] ?? 'Please Update the Name';
          email.value = userData['email'] ?? 'Please Update the Email';
        }
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  Future<void> updateUserData() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'name': name.value,
          'email': email.value,
        });
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}
