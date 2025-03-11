import 'package:flutter/material.dart';
import 'package:grocery_store_app/views/widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.abc_outlined,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ///
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/photo_profile.png',
                      width: 140,
                      height: 140,
                    ),
                    SizedBox(height: 13),
                    Text(
                      'Muhammad Iqbal Al Afgany',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'DESIGNER',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xffABABAB),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              ///
              ProfileItem(
                title: 'Your Email',
                icon: Icons.email_outlined,
                text: 'xxx@gmail.com',
              ),
              SizedBox(height: 20),

              ///
              ProfileItem(
                title: 'Phone Number',
                icon: Icons.phone,
                text: '+93123135',
              ),
              SizedBox(height: 20),

              ///
              ProfileItem(
                title: 'Address',
                icon: Icons.home,
                text: 'Surabaya',
              ),
              SizedBox(height: 20),

              ///
              ProfileItem(
                title: 'Password',
                icon: Icons.lock,
                text: '********',
                trailingIcon: Icons.remove_red_eye_sharp,
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}
