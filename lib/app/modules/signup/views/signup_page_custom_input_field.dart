import 'package:flutter/material.dart';

class SignUpPageCustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool obsecure;

  const SignUpPageCustomInputField({
    required this.controller,
    required this.title,
    this.obsecure = false,
  });

  @override
  _SignUpPageCustomInputFieldState createState() => _SignUpPageCustomInputFieldState();
}

class _SignUpPageCustomInputFieldState extends State<SignUpPageCustomInputField> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
      child: TextField(
        obscureText: widget.obsecure ? !_isPasswordVisible : false,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.title == "Password"
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: widget.title,
        ),
      ),
    );
  }
}
