import 'package:flutter/material.dart';
import 'package:grocery_store_app/views/constants/app_routes.dart';
import 'package:grocery_store_app/views/widgets/text_field.dart';

import '../widgets/custom_login_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                    'Sign Up',
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
                    'Enter your credentials to continue',
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
                hintText: 'Masukkan nama anda',
                text: 'Nama',
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
                  hintText: 'Masukkan email anda',
                  obscureText: true,
                )),
            const SizedBox(height: 30),

            ///
            const Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: CustomTextField(
                  text: 'Password',
                  hintText: 'Masukkan password anda',
                  obscureText: true,
                )),
            const SizedBox(height: 30),

            ///
            const Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: CustomTextField(
                  text: 'Address',
                  hintText: 'Masukkan address anda',
                  obscureText: true,
                )),
            const SizedBox(height: 30),

            ///
            const Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: CustomTextField(
                  text: 'Phone',
                  hintText: 'Masukkan phone anda',
                  obscureText: true,
                )),
            const SizedBox(height: 30),

            ///
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  right: 25,
                ),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            ///
            Center(
              child: SignInButton(
                text: 'Sign Up',
                onTap: () => Navigator.pushNamed(context, AppRoutes.navbar),
              ),
            ),
            const SizedBox(height: 25),

            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xff181725),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Singin',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xff53B175),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 75),
          ],
        ),
      ),
    );
  }
}
