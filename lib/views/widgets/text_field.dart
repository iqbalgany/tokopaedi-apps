import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final bool obscureText;
  const CustomTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xff7C7C7C),
            ),
          ),
          TextField(
            obscureText: obscureText,
            decoration: InputDecoration(hintText: hintText),
          )
        ],
      ),
    );
  }
}
