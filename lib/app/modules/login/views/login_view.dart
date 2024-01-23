import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:itsurgent/app/modules/login/views/custom_input_field.dart';
import 'package:itsurgent/app/modules/signup/views/signup_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController otpController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to It's Urgent!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Login to continue',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Form(
                  child: Column(
                children: [
                  Semantics(
                    label: 'Phone No',
                    textField: true,
                    child: CustomInputField(
                        controller: phoneController, title: 'Phone No'),
                  ),
                  const SizedBox(height: 20),
                  Semantics(
                    label: 'Otp',
                    textField: true,
                    child: CustomInputField(
                      controller: otpController,
                      title: 'Otp',
                      obsecure: true,
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff200589),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {},
                child: const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(const Color(0xff200589)),
                    ),
                    onPressed: () {
                      Get.to(const SignupView());
                    },
                    child: const Text('Register', style: TextStyle(fontSize: 18)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
