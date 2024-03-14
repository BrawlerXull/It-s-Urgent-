// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  Future<bool> requestPermission() async {
    try {
      return await FlutterContacts.requestPermission(readonly: true);
    } catch (e) {
      print('Error requesting contacts permission: $e');
      return false;
    }
  }

  Future<List<Contact>> fetchContacts() async {
    try {
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
    } catch (e) {
      print('Error fetching contacts: $e');
      throw e;
    }
  }
}
