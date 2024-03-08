import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallingService{
  void makePhoneCall() async {
    await FlutterPhoneDirectCaller.callNumber("9420114728");
  }
}