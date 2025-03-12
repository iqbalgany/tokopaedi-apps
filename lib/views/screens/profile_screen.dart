import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/user_controller.dart';
import 'package:grocery_store_app/model/user_model.dart';
import 'package:grocery_store_app/views/widgets/profile_item.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel? user;
  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        loadUser();
      },
    );
  }

  void loadUser() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      await Provider.of<UserController>(context, listen: false)
          .fetchedUser(context);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load user data: ${e.toString()}';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context, listen: false);

    return Consumer<UserController>(
      builder: (context, userController, child) {
        final user = provider.user! ?? widget.user;
        return Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.abc_outlined,
              color: Colors.white,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  editProfile();
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
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
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/profile_picture.jpeg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(height: 13),
                    ],
                  ),
                ),
                SizedBox(height: 32),

                ///
                ProfileItem(
                  title: 'Your Name',
                  icon: Icons.person_2_outlined,
                  text: user!.name,
                ),
                SizedBox(height: 20),

                ///
                ProfileItem(
                  title: 'Your Email',
                  icon: Icons.email_outlined,
                  text: user.email,
                ),
                SizedBox(height: 20),

                ///
                ProfileItem(
                  title: 'Your Role',
                  icon: Icons.chair_outlined,
                  text: user.role!,
                ),
                SizedBox(height: 20),

                ///
                if (user.emailVerifiedAt != null &&
                    user.emailVerifiedAt!.isNotEmpty)
                  ProfileItem(
                    title: 'Email Status',
                    icon: Icons.verified,
                    text: 'Verified',
                  ),

                ///
                if (user.createdAt != null)
                  ProfileItem(
                    title: 'Member Since',
                    icon: Icons.calendar_today,
                    text:
                        '${user.createdAt!.day}/${user.createdAt!.month}/${user.createdAt!.year}',
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void editProfile() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),

            Align(
              alignment: Alignment.center,
              child: Container(
                width: 60,
                height: 3,
                decoration: BoxDecoration(color: Colors.green),
              ),
            ),
            SizedBox(height: 30),

            ///
            ProfileItem(
              title: 'Name',
              icon: Icons.email_outlined,
              text: 'Bambang Tabootie',
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
          ],
        ),
      ),
    );
  }
}
