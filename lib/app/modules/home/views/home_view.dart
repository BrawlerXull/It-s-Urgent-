import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("It's Urgent"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                controller.signOut();
              },
            )
          ],
          automaticallyImplyLeading: false,
        ),
        body: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.permissionDenied.value) {
              return const Center(child: Text('Permission denied'));
            }
            if (controller.contacts == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: controller.contacts!.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(controller.contacts![i].displayName),
                subtitle: Text(controller.contacts![i].phones.first.number),
              ),
            );
          },
        ),
      ),
    );
  }
}
