import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool obsecure;

  const CustomInputField({
    required this.controller,
    required this.title,
    this.obsecure = false,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
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
          fillColor: Colors.grey[200],
          filled: true,
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
          focusColor: Colors.grey[200],
          hoverColor: Colors.grey[200],
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: widget.title,
        ),
      ),
    );
  }
}
