import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class ContactService {
  List<Contact>? contacts = <Contact>[].obs;
  bool permissionDenied = false;

  Future<List<Contact>?> fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      permissionDenied = true;
    } else {
      final fetchedContacts = await FlutterContacts.getContacts();
      contacts = fetchedContacts;
      for (int i = 0; i < contacts!.length; i++) {
        contacts![i] = (await FlutterContacts.getContact(contacts![i].id))!;
      }
    }
    return contacts;
  }
}
