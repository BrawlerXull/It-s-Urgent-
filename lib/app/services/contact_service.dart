import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  Future<bool> requestPermission() async {
    return await FlutterContacts.requestPermission(readonly: true);
  }

  Future<List<Contact>> fetchContacts() async {
    final fetchedContacts = await FlutterContacts.getContacts();
    final List<Contact> contacts = [];

    for (final contact in fetchedContacts) {
      contacts.add((await FlutterContacts.getContact(contact.id))!);
    }

    return contacts;
  }
}
