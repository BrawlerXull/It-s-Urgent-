import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:itsurgent/app/modules/settings/views/settings_page_tile.dart';

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
        body: Column(
          children: [
            const SizedBox(height: 20,),
            CustomTileSettingsPage(
              title: "Get Secret Code",
              subTitle: 'Tap to get Secret Code',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Secret Key'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            controller.secretCode.value,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: controller.secretCode.value));
                            Get.snackbar('Copied to Clipboard', '');
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
