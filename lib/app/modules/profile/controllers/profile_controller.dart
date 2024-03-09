// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:itsurgent/app/services/services.dart';

class ProfileController extends GetxController {
  late final FirestoreService firestoreService;
  ProfileController() {
    firestoreService = FirestoreService();
  }

  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxInt urgencyStatus = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final userData = await firestoreService.getUserData();
      name.value = userData['name'] ?? 'Please Update the Name';
      email.value = userData['email'] ?? 'Please Update the Email';
      urgencyStatus.value = userData['urgencyStatus'] ?? 1;
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData(
      String newName, String newEmail, int urgencyStatus) async {
    try {
      await firestoreService.updateUserData(newName, newEmail, urgencyStatus);
      name.value = newName;
      email.value = newEmail;
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}
