import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_floating_action_button.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_info_tile.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      floatingActionButton: Obx(
        () => ProfilePageFloatingActionButton(
          onPressedSave: () {
            controller.updateUserData(nameController.text.trim(),
                emailController.text.trim(), controller.urgencyStatus.value);
            Get.back();
          },
          onPressedCancel: () {
            Get.back();
          },
          nameController: nameController,
          emailController: emailController,
          urgencyStatus: controller.urgencyStatus.value,
          onDropDownChanged: (int? value) {
            controller.urgencyStatus.value = value!;
          },
        ),
      ),
      body: Obx(
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
      ),
    );
  }
}
