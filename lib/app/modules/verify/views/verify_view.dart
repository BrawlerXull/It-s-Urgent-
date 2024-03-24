// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:itsurgent/app/modules/verify/views/verify_page_body.dart';
import 'package:get/get.dart';
import '../controllers/verify_controller.dart';

class VerifyView extends GetView<VerifyController> {
  const VerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: VerifyPageBody(
          controller: controller,
        ),
      ),
    );
  }
}
