import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_alert_dialog.dart';
import 'package:itsurgent/app/modules/profile/views/profile_page_body.dart';
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
      body: ProfilePageBody(
        controller: controller,
      ),
    );
  }
}
