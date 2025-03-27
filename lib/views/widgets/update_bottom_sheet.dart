import 'package:flutter/material.dart';

class UpdateBottomSheet extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final VoidCallback onUpdateProfile;
  final bool obscurePassword;
  final Function() toggleObscurePassword;
  const UpdateBottomSheet({
    super.key,
    required this.nameController,
    required this.passwordController,
    required this.onUpdateProfile,
    required this.obscurePassword,
    required this.toggleObscurePassword,
  });

  @override
  State<UpdateBottomSheet> createState() => _UpdateBottomSheetState();
}

class _UpdateBottomSheetState extends State<UpdateBottomSheet> {
  @override
  Widget build(BuildContext context) {
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
                      controller: widget.nameController,
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
                      controller: widget.passwordController,
                      obscureText: widget.obscurePassword,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter new password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        prefixIconColor: Colors.green,
                        suffixIcon: IconButton(
                          onPressed: widget.toggleObscurePassword,
                          icon: Icon(widget.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        suffixIconColor:
                            widget.obscurePassword ? Colors.grey : Colors.green,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),

            GestureDetector(
              onTap: widget.onUpdateProfile,
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
  }
}
