// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/routes/app_pages.dart';

class ContactTileHomePage extends StatelessWidget {
  final Contact contact;
  final void Function()? onTap;

  const ContactTileHomePage({
    required this.contact,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.displayName),
      subtitle: Text(contact.phones.first.number),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 57, 142, 208),
        child: Text(
          contact.displayName[0],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      trailing: GestureDetector(
        onTap: onTap,
        child: const Icon(Icons.call),
      ),
      onTap: () {
        print("ok");
        Get.toNamed(Routes.MESSAGE, arguments: {'contact': contact});
      },
    );
  }
}
