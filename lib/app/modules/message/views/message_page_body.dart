import 'package:flutter/material.dart';
import 'package:itsurgent/app/modules/message/controllers/message_controller.dart';
import 'package:itsurgent/app/modules/message/views/message_page_tiles_list.dart';

class MessagePageBody extends StatelessWidget {
  final MessageController controller;
  const MessagePageBody({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          MessagePageTilesList(
            controller: controller,
          ),
        ],
      ),
    );
  }
}
