import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_custom_input_field.dart';
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Edit Profile'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomInputFieldProfilePage(
                    controller: nameController,
                    hintText: "Enter the name",
                    labelText: 'Name',
                  ),
                  const SizedBox(height: 20),
                  CustomInputFieldProfilePage(
                    controller: emailController,
                    hintText: "Enter the Email",
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 20),
                  const Text("Urgency Status"),
                  const SizedBox(height: 5),
                  Obx(
                    () => DropdownButton<int>(
                      value: controller.urgencyStatus.value,
                      onChanged: (int? value) {
                        controller.urgencyStatus.value = value!;
                      },
                      items: const [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('Low'),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text('Medium'),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text('High'),
                        ),
                      ],
                    ),
                  ),
                  const Text("Service Status"),
                  Obx(
                    () => Switch(
                      value: controller.switchValue.value,
                      onChanged: (newValue) {
                        controller.switchValue.value =
                            !controller.switchValue.value;
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.grey,
                      activeTrackColor: Colors.lightBlueAccent,
                      inactiveTrackColor: Colors.grey[400],
                    ),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    controller.updateUserData(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        controller.urgencyStatus.value);
                    Get.back();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.edit),
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
