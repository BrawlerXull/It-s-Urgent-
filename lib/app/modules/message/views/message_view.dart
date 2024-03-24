import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/message/views/message_page_body.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: MessagePageBody(
        controller: controller,
      ),
    );
  }
}
