import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarHomePage extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const SearchBarHomePage(
      {required this.controller, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
    contentPadding: const EdgeInsets.all(10.0),
          fillColor: Colors.grey[200],
          filled: true,
          focusColor: Colors.grey[200],
          hoverColor: Colors.grey[200],
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
