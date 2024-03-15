import 'package:flutter/material.dart';

class CustomTileMessagePage extends StatelessWidget {
  final String title;
  final String subTitle;
  const CustomTileMessagePage(
      {required this.title, required this.subTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 246, 246, 246),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              subTitle,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
