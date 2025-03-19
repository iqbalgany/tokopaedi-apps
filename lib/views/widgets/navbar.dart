import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/user_controller.dart';
import 'package:grocery_store_app/views/screens/home_screen.dart';
import 'package:grocery_store_app/views/screens/order_screen.dart';
import 'package:grocery_store_app/views/screens/profile_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 0;
  UserController userController = UserController();

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    userController.fetchedUser(context);
  }

  Widget buildContent(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const OrderScreen();
      case 2:
        return userController.user == null
            ? const Center(child: CircularProgressIndicator())
            : ProfileScreen(user: userController.user!);
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildContent(currentIndex),
          customNavigationBar(context),
        ],
      ),
    );
  }

  Align customNavigationBar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.only(top: 21),
        height: 92,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.2),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ///
            navbarItem(
                icon: Icons.shopping_basket_outlined, index: 0, text: 'Shop'),

            ///
            navbarItem(icon: Icons.notes_rounded, index: 1, text: 'Order'),

            ///
            navbarItem(
                icon: Icons.account_circle_outlined, index: 2, text: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget navbarItem({
    String? text,
    int? index,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: () {
        onTabTapped(index!);
      },
      child: Column(
        children: [
          Icon(
            icon!,
            color: currentIndex == index ? Colors.green : Colors.black,
          ),
          Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: currentIndex == index ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
