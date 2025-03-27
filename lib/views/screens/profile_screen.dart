import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/user_controller.dart';
import 'package:grocery_store_app/models/user_model.dart';
import 'package:grocery_store_app/views/widgets/profile_item.dart';
import 'package:grocery_store_app/views/widgets/profile_shimmer_item.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUser();
    });
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

  Future<void> _updateProfile() async {
    final String name = _nameController.text.trim();
    final String password = _passwordController.text.trim();

    await Provider.of<UserController>(context, listen: false).updateUser(
      context: context,
      name: name,
      password: password.isEmpty ? null : password,
    );

    Navigator.pop(context);
    loadUser();
  }

  void _showUpdateBottomSheet(UserModel user) {
    _nameController.text = user.name;
    _passwordController.clear();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 450,
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 60,
                    height: 3,
                    decoration: const BoxDecoration(color: Colors.green),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 54,
                        padding: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Enter your new name',
                            prefixIcon: Icon(Icons.person_2_outlined),
                            prefixIconColor: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                ///
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 54,
                        padding: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Enter new password',
                            prefixIcon: const Icon(Icons.lock_outlined),
                            prefixIconColor: Colors.green,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            suffixIconColor:
                                _obscurePassword ? Colors.grey : Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                GestureDetector(
                  onTap: _updateProfile,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width - 0.6,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, child) {
        ///
        if (_errorMessage != null) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text(_errorMessage!),
                  ElevatedButton(
                    onPressed: loadUser,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        ///
        final user = userController.user ?? widget.user;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => _showUpdateBottomSheet(user!),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                ),

                ///
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      if (_isLoading)
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 170,
                            height: 170,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 170,
                          height: 170,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/profile_picture.jpeg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      const SizedBox(height: 13),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                ///
                if (_isLoading)
                  const ProfileShimmerItem()
                else
                  ProfileItem(
                    title: 'Your Name',
                    icon: Icons.person_2_outlined,
                    text: user!.name,
                  ),
                const SizedBox(height: 20),

                ///
                if (_isLoading)
                  const ProfileShimmerItem()
                else
                  ProfileItem(
                    title: 'Your Email',
                    icon: Icons.email_outlined,
                    text: user!.email,
                  ),
                const SizedBox(height: 20),

                ///
                if (_isLoading)
                  const ProfileShimmerItem()
                else
                  ProfileItem(
                    title: 'Your Role',
                    icon: Icons.chair_outlined,
                    text: user!.role!,
                  ),
                const SizedBox(height: 20),

                ///
                if (_isLoading)
                  const ProfileShimmerItem()
                else if (user!.createdAt != null)
                  ProfileItem(
                    title: 'Member Since',
                    icon: Icons.calendar_today,
                    text:
                        '${user.createdAt!.day}/${user.createdAt!.month}/${user.createdAt!.year}',
                  ),

                ///
                GestureDetector(
                  onTap: () {
                    // userController.signOut(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(24, 20, 24, 100),
                    width: MediaQuery.sizeOf(context).width,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
