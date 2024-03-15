import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 246, 246, 246),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Send Urgent Notification",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      false
                          ? "Tap to send"
                          : 'User has turned off the services',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 246, 246, 246),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Make a phone call",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Tap to call!',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 246, 246, 246),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Chat on WhatsApp",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Tap to chat!',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
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
