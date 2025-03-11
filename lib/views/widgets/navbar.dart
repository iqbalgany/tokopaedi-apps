import 'package:flutter/material.dart';
import 'package:grocery_store_app/views/screens/cart_screen.dart';
import 'package:grocery_store_app/views/screens/home_screen.dart';
import 'package:grocery_store_app/views/screens/profile_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget buildContent(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return CartScreen();
      case 2:
        return ProfileScreen();

      default:
        return HomeScreen();
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
        padding: EdgeInsets.only(top: 21),
        height: 92,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.vertical(
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
            navbarItem(
                icon: Icons.shopping_cart_outlined, index: 1, text: 'Cart'),

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
            size: 24,
          ),
          Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: currentIndex == index ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
