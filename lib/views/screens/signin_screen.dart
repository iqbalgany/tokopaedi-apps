import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/auth_controller.dart';
import 'package:grocery_store_app/views/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
import '../widgets/custom_login_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context, listen: false);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
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
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: CustomTextField(
                hintText: 'Masukkan email anda',
                text: 'Email',
                controller: emailController,
              ),
            ),
            const SizedBox(height: 30),

            ///
            Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: CustomTextField(
                  text: 'Password',
                  hintText: 'Masukkan password anda',
                  obscureText: true,
                  controller: passwordController,
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
                onTap: () async {
                  await provider.signIn(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context);
                },
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
                    'SingUp',
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
