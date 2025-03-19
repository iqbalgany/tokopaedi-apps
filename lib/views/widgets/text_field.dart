import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  const CustomTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xff7C7C7C),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(hintText: hintText),
        )
      ],
    );
  }
}
