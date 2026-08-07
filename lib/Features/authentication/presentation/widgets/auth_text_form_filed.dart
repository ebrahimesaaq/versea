import 'package:flutter/material.dart';

class AuthTextFormFiled extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  const AuthTextFormFiled({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    required this.title,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Libertinus',
          ),
        ),
        TextFormField(
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontFamily: 'Libertinus',
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            border: UnderlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
