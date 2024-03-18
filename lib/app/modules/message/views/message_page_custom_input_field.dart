import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputFieldMessagePage extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomInputFieldMessagePage(
      {required this.controller, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
