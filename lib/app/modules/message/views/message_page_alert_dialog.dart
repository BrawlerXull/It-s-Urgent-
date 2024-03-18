import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/message/controllers/message_controller.dart';
import 'package:itsurgent/app/modules/message/views/message_page_custom_input_field.dart';

void showNotificationDialog(
    BuildContext context, TextEditingController messageController, MessageController controller) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Send Notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInputFieldMessagePage(controller: messageController, hintText: "Enter the message here"),
            Obx(
              () => Slider(
                value: controller.urgencyRatingValue.value.toDouble(),
                min: 1,
                max: 3,
                divisions: 2,
                onChanged: (newValue) {
                  controller.urgencyRatingValue.value = newValue.round();
                },
                label: controller.urgencyRatingValue.value == 1
                    ? 'Low'
                    : (controller.urgencyRatingValue.value == 2 ? 'Medium' : 'High'),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Low'),
                Text('Medium'),
                Text('High'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.sendMessage(messageController.text.trim());
            },
            child: const Text('Send'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
