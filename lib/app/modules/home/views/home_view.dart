import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itsurgent/app/modules/home/views/home_page_contact_tile.dart';
import 'package:itsurgent/app/modules/home/views/home_page_search_bar.dart';
import 'package:itsurgent/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
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
          ),
          body: GetBuilder<HomeController>(
            builder: (controller) {
              if (controller.permissionDenied.value) {
                return const Center(child: Text('Permission denied'));
              }
              if (controller.contacts == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  SearchBarHomePage(controller: searchController, hintText: "Search here"),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.contacts!.length,
                      itemBuilder: (context, i) => ContactTileHomePage(
                        contact: controller.contacts![i],
                        onTap: controller.makePhoneCall,
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
