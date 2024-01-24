import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itsurgent/app/modules/login/views/custom_input_field.dart';
import 'package:itsurgent/app/modules/login/views/login_view.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                      child: CustomInputField(
                        controller: nameController,
                        title: 'Name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Semantics(
                      label: 'Phone No',
                      textField: true,
                      child: CustomInputField(
                        controller: emailController,
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
                        
                      },
                      child: const Text('Send OTP'),
                    ),
                    const SizedBox(height: 20),
                    Semantics(
                      label: 'Otp',
                      textField: true,
                      child: CustomInputField(
                        controller: passwordController,
                        title: 'Otp',
                        obsecure: true,
                      ),
                    ),
                  ],
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
                onPressed: () {},
                child: const Text('Signup'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff200589),
                      ),
                    ),
                    onPressed: () {
                      Get.to(const LoginView());
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 18)),
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
