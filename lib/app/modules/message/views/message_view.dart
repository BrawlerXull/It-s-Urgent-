import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:itsurgent/app/modules/message/views/message_page_tile.dart';

import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
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
        const Column(
          children: [
            CustomTileMessagePage(
              title: "Send Urgent Notification",
              subTitle:
                  false ? "Tap to send" : 'User has turned off the services',
              icon: Icons.notifications_active,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTileMessagePage(
              title: "Make a phone call",
              subTitle: 'Tap to call!',
              icon: Icons.call,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTileMessagePage(
              title: "Chat on WhatsApp",
              subTitle: 'Tap to chat!',
              icon: Icons.chat,
            ),
          ],
        )

        // Row(
        //   children: [
        //     RawMaterialButton(
        //       onPressed: () {},
        //       padding: const EdgeInsets.all(15.0),
        //       shape: const CircleBorder(
        //         side: BorderSide(color: Colors.black, width: 2.0),
        //       ),
        //       child: const Icon(
        //         Icons.call,
        //         size: 35.0,
        //       ),
        //     ),
        //   ],
        // )
      ],
    ));
  }
}
