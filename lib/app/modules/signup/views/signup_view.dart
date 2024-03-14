import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/signup/views/signup_page_custom_input_field.dart';
import 'package:itsurgent/app/modules/signup/controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    final TextEditingController nameController = TextEditingController();

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
                'SignUp to continue',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    Semantics(
                      label: 'Name',
                      textField: true,
                      child: SignUpPageCustomInputField(
                        controller: nameController,
                        title: 'Name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Semantics(
                      label: 'Phone No',
                      textField: true,
                      child: SignUpPageCustomInputField(
                        controller: phoneController,
                        title: 'Phone No',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff200589),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      onPressed: () {
                        controller.phoneNumber.value = phoneController.text;
                        controller.name.value = nameController.text;
                        controller.sendOtp();
                      },
                      child: const Text('Send OTP'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
