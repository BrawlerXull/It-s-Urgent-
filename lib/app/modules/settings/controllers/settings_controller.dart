import 'package:get/get.dart';
import 'package:itsurgent/app/services/firestore_service.dart';

class SettingsController extends GetxController {
  RxString secretCode = ''.obs;

  late final FirestoreService firestoreService;
  SettingsController() {
    firestoreService = FirestoreService();
    getSecretCode();
  }
  void getSecretCode() async {
    secretCode.value = (await firestoreService.getSecretCode())!;
  }
}
