import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/settings/views/settings_page_body.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsView'),
        centerTitle: true,
      ),
      body: SettingsPageBody(
        controller: controller,
      ),
    );
  }
}
