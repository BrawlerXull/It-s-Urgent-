import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';
import 'package:itsurgent/app/services/services.dart';

class HomeController extends GetxController {
  late final AuthenticationService authenticationService;
  late final NotificationService notificationService;
  late final FirestoreService firestoreService;
  late final ContactService contactService;
  late final CallingService callingService;

  HomeController() {
    authenticationService = AuthenticationService();
    notificationService = NotificationService();
    firestoreService = FirestoreService();
    contactService = ContactService();
    callingService = CallingService();
  }

  RxList<Contact>? contacts = <Contact>[].obs;
  RxBool permissionDenied = false.obs;

  void fetchContacts() async {
    final hasPermission = await contactService.requestPermission();
    permissionDenied.value = !hasPermission;

    if (hasPermission) {
      contacts!.value = await contactService.fetchContacts();
      update();
    }
  }

  void signOut() {
    authenticationService.signOut();
    Get.toNamed(Routes.SIGNUP);
  }

  Future<String> getDeviceToken() async {
    return notificationService.getDeviceToken();
  }

  void updateUserFCMToken(String fcmToken) {
    firestoreService.updateUserFCMToken(fcmToken);
  }

  void makePhoneCall() {
    callingService.makePhoneCall();
  }

  void firebaseInit() {
    notificationService.firebaseInit();
  }

  @override
  void onInit() {
    super.onInit();
    getDeviceToken().then(updateUserFCMToken);
    firebaseInit();
    fetchContacts();
  }
}
