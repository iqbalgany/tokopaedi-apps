import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/auth_controller.dart';
import 'package:grocery_store_app/views/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_login_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthController>(context, listen: false);
    TextEditingController nameController = TextEditingController();
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
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: CustomTextField(
                hintText: 'Masukkan nama anda',
                text: 'Nama',
                controller: nameController,
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
                  text: 'Email',
                  hintText: 'Masukkan email anda',
                  controller: emailController,
                )),
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
                onTap: () async {
                  await provider.signUp(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    context: context,
                  );
                },
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
                    'SingIn',
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
