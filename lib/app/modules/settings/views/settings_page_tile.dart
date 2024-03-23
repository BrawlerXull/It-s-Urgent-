import 'package:flutter/material.dart';

class CustomTileSettingsPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onTap;
  const CustomTileSettingsPage({
    required this.title,
    required this.subTitle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? Colors.grey[800] 
        : const Color.fromARGB(255, 246, 246, 246);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(color: backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Row(
            children: [
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
