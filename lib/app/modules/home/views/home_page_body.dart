import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/home/controllers/home_controller.dart';
import 'package:itsurgent/app/modules/home/views/home_page_contact_tile.dart';
import 'package:itsurgent/app/modules/home/views/home_page_search_bar.dart';

class HomePageBody extends StatelessWidget {
  final HomeController controller;
  const HomePageBody({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return GetBuilder<HomeController>(
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
    );
  }
}
