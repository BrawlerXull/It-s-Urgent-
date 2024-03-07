import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';
import 'package:itsurgent/app/services/services.dart';

class HomeController extends GetxController {
  late final AuthenticationService authenticationService;
  late final NotificationService notificationService;
  late final FirestoreService firestoreService;
  late final ContactService contactService;

  HomeController() {
    authenticationService = AuthenticationService();
    notificationService = NotificationService();
    firestoreService = FirestoreService();
    contactService = ContactService();
  }

  RxList<Contact>? contacts = <Contact>[].obs;
  RxBool permissionDenied = false.obs;

  Future<void> fetchContacts() async {
    final hasPermission = await contactService.requestPermission();
    permissionDenied.value = !hasPermission;

    if (!hasPermission) {
      return; 
    }

    contacts!.value = await contactService.fetchContacts();
    update();
  }

  Future<void> signOut() async {
    authenticationService.signOut();
    Get.toNamed(Routes.SIGNUP);
  }

  Future<String> getDeviceToken() async {
    return notificationService.getDeviceToken();
  }

  Future<void> updateUserFCMToken(String fcmToken) async {
    firestoreService.updateUserFCMToken(fcmToken);
  }

  @override
  void onInit() {
    super.onInit();
    getDeviceToken().then(updateUserFCMToken);
    fetchContacts();
  }
}
