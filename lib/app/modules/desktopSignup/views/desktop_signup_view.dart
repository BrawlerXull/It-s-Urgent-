import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/desktop_signup_controller.dart';

class DesktopSignupView extends GetView<DesktopSignupController> {
  const DesktopSignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DesktopSignupView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DesktopSignupView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
