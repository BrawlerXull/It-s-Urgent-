// ignore_for_file: avoid_print

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallingService {
  Future<void> makePhoneCall() async {
    try {
      await FlutterPhoneDirectCaller.callNumber("+919420114728");
      print('Phone call initiated to +919420114728');
    } catch (e) {
      print('Error making phone call: $e');
      rethrow;
    }
  }
}
