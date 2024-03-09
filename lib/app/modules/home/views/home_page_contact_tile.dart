import 'package:flutter/material.dart';

import 'package:flutter_contacts/flutter_contacts.dart';

class ContactTileHomePage extends StatelessWidget {
  final Contact contact;
  final void Function()? onTap;

  const ContactTileHomePage(
      {required this.contact, required this.onTap, super.key});

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
    );
  }
}
