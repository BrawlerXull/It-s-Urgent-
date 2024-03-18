import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/profile/controllers/profile_controller.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_custom_input_field.dart';

void showEditProfileDialog(BuildContext context, TextEditingController nameController,
    TextEditingController emailController, ProfileController controller) {
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
                controller.switchValue.value = !controller.switchValue.value;
              },
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
              controller.urgencyStatus.value,
              controller.switchValue.value,
            );
            Get.back();
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
