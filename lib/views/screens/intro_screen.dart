import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store_app/views/screens/home_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// LOGO
          Padding(
            padding: const EdgeInsets.only(
              left: 80,
              right: 80,
              bottom: 40,
              top: 120,
            ),
            child: Image.asset(
              'assets/avocado.png',
              scale: 3,
            ),
          ),

          /// WE DELIVER GROCERIES AT YOUR DOORSTEP
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'We deliver groceries at your doorstep',
              style: GoogleFonts.notoSerif(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          /// FRESH ITEMS EVERYDAY
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Groceer gives you fresh vegetables and fruits, Order fresh items from groceer.',
              style: TextStyle(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),

          /// GET STARTED BUTTON
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
