import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';

class HomeController extends GetxController {
  RxList<Contact>? contacts = <Contact>[].obs;
  RxBool permissionDenied = false.obs;

  Future<void> fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      permissionDenied.value = true;
    } else {
      var fetchedContacts = await FlutterContacts.getContacts();
      contacts = fetchedContacts.obs;
      for (int i = 0; i < contacts!.length; i++) {
        contacts![i] = (await FlutterContacts.getContact(contacts![i].id))!;
      }
    }
    update();
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.toNamed(Routes.SIGNUP);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }
}
