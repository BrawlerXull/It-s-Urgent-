import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/message/views/message_page_alert_dialog.dart';
import 'package:itsurgent/app/modules/message/views/message_page_tile.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Align(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: const Color(0xFFA5D8FF),
                      child: Text(
                        controller.contactName.value[0],
                        style: const TextStyle(fontSize: 70, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.contactName.value,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Obx(
                    () => CustomTileMessagePage(
                      title: "Send Urgent Notification",
                      subTitle: controller.doesUserExists.value
                          ? (controller.isUrgencyServiceOn.value ? "Tap to send" : 'User has turned off the services')
                          : 'User does not exist',
                      icon: controller.doesUserExists.value
                          ? controller.isUrgencyServiceOn.value
                              ? Icons.notifications_active
                              : Icons.error
                          : Icons.error,
                      onTap: () {
                        if (controller.doesUserExists.value) {
                          if (controller.isUrgencyServiceOn.value) {
                            showNotificationDialog(context, messageController, controller);
                          } else {
                            Get.snackbar("Unable to send message", "User has turned off the services");
                          }
                        } else {
                          Get.snackbar("Unable to send message", "User does not exist");
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTileMessagePage(
                    title: "Make a phone call",
                    subTitle: 'Tap to call!',
                    icon: Icons.call,
                    onTap: null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTileMessagePage(
                    title: "Chat on WhatsApp",
                    subTitle: 'Tap to chat!',
                    icon: Icons.chat,
                    onTap: null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTileMessagePage(
                    title: "Block the user",
                    subTitle: 'Tap to block!',
                    icon: Icons.block,
                    onTap: controller.addToBlockList,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTileMessagePage(
                    title: "Report ther user",
                    subTitle: 'Tap to report!',
                    icon: Icons.report,
                    onTap: null,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
