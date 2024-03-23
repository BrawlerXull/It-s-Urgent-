import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/theme/custom_theme.dart';
import 'package:itsurgent/app/utils/consts.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // QuickTileService quickTileService = QuickTileService();
  // quickTileService.initQuickTile();

  User? user = FirebaseAuth.instance.currentUser;
  
  String initialRoute = user != null ? Routes.HOME : Routes.SIGNUP;


  runApp(
    SafeArea(
      child: GetMaterialApp(
        title: "Application",
        initialRoute: kIsDesktop ? Routes.DESKTOP_SIGNUP : initialRoute,
        getPages: AppPages.routes,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    ),
  );
}
