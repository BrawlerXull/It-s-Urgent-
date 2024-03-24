import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/home/views/home_page_appbar.dart';
import 'package:itsurgent/app/modules/home/views/home_page_body.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBarHomePage(
          controller: controller,
        ),
        body: HomePageBody(
          controller: controller,
        ),
      ),
    );
  }
}
