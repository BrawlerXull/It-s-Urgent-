import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  Future<bool> requestPermission() async {
    return await FlutterContacts.requestPermission(readonly: true);
  }

  Future<List<Contact>> fetchContacts() async {
    final fetchedContacts = await FlutterContacts.getContacts();
    final List<Contact> contacts = [];

    final List<Future<Contact?>> contactFutures = [];
    for (final contact in fetchedContacts) {
      contactFutures.add(FlutterContacts.getContact(contact.id));
    }

    final List<Contact?> resolvedContacts = await Future.wait(contactFutures);

    for (final contact in resolvedContacts) {
      if (contact != null) {
        contacts.add(contact);
      }
    }

    return contacts;
  }
}
