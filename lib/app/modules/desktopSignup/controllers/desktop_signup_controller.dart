import 'package:get/get.dart';
import 'package:itsurgent/app/services/firestore_service.dart';

class DesktopSignupController extends GetxController {
  late final FirestoreService firestoreService;

  DesktopSignupController() {
    firestoreService = FirestoreService();
  }
  void verifySecrectCode() async {
    print("ok");
    print(await firestoreService.verifySecretCode('cccccc'));
  }
}
