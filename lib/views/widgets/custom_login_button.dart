import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const SignInButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 364,
        height: 67,
        decoration: BoxDecoration(
          color: Color(0xff53B175),
          borderRadius: BorderRadius.circular(19),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
