import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_alert_dialog.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_info_tile.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditProfileDialog(context, nameController, emailController, controller);
        },
        child: const Icon(Icons.edit),
      ),
      body: FutureBuilder(
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
      ),
    );
  }
}
