import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/services/services.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  QuickTileService quickTileService = QuickTileService();
  quickTileService.initQuickTile();

  User? user = FirebaseAuth.instance.currentUser;

  runApp(
    SafeArea(
      child: GetMaterialApp(
        title: "Application",
        initialRoute: user != null ? Routes.HOME : Routes.SIGNUP,
        getPages: AppPages.routes,
      ),
    ),
  );
}
