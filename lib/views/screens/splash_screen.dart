import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store_app/constants/app_routes.dart';
import 'package:grocery_store_app/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    String? token = await StorageService.getToken();

    Future.delayed(const Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.navbar,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.signIn,
        );
      }
    });
  }

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
        ],
      ),
    );
  }
}
