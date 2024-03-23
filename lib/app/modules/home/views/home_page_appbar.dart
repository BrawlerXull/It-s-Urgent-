import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itsurgent/app/modules/home/controllers/home_controller.dart';
import 'package:itsurgent/app/routes/app_pages.dart';

class AppBarHomePage extends StatelessWidget implements PreferredSizeWidget {
  final HomeController controller;

  const AppBarHomePage({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "It's Urgent",
        style: GoogleFonts.acme(),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Get.toNamed(Routes.PROFILE);
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Get.toNamed(Routes.SETTINGS);
          },
        ),
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            controller.signOut();
          },
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
