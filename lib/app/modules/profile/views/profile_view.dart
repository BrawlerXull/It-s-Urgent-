import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Edit Profile'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
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
                    String newName = nameController.text.trim();
                    String newEmail = emailController.text.trim();
                    controller.name.value = newName;
                    controller.email.value = newEmail;
                    controller.updateUserData();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Name"),
          Obx(() => Text(controller.name.value)),
          const Text("Email"),
          Obx(() => Text(controller.email.value)),
        ],
      ),
    );
  }
}
