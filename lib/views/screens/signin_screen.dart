import 'package:flutter/material.dart';
import 'package:grocery_store_app/views/constants/app_routes.dart';
import 'package:grocery_store_app/views/widgets/text_field.dart';

import '../widgets/custom_login_button.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: Image.asset(
                'assets/carrot.png',
                width: 47.84,
                height: 55.64,
              ),
            ),
            const SizedBox(height: 100.21),
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: Color(0xff181725),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Enter your emails and password',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Color(0xff7C7C7C),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            ///
            const Padding(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: CustomTextField(
                hintText: 'Masukkan email anda',
                text: 'Email',
              ),
            ),
            const SizedBox(height: 30),

            ///
            const Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: CustomTextField(
                  text: 'Email',
                  hintText: 'Masukkan password anda',
                  obscureText: true,
                )),

            ///
            const Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 25,
                left: 25,
              ),
              child: Text(
                'By continuing you agree to our Terms of Service and Privacy Policy.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),

            ///
            Center(
              child: SignInButton(
                text: 'Sign In',
                onTap: () => Navigator.pushNamed(context, AppRoutes.navbar),
              ),
            ),
            const SizedBox(height: 25),

            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don’t have an account? ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xff181725),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.signUp),
                  child: const Text(
                    'Singup',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xff53B175),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
