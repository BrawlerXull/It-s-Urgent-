import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/profile/controllers/profile_controller.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_info_tile.dart';

class ProfilePageBody extends StatelessWidget {
  final ProfileController controller;
  const ProfilePageBody({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
                ProfilePageInfoTile(title: "Name", value: controller.name.value),
                ProfilePageInfoTile(title: "Email", value: controller.email.value),
              ],
            ),
          );
        }
      },
    );
  }
}
