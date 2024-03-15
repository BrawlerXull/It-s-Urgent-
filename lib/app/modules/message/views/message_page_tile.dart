import 'package:flutter/material.dart';

class CustomTileMessagePage extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final void Function()? onTap;
  const CustomTileMessagePage({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 246, 246, 246),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(
                width: 20,
              ),
              Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
