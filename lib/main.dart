import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/auth_controller.dart';
import 'package:grocery_store_app/controllers/cart_controller.dart';
import 'package:grocery_store_app/controllers/checkout_controller.dart';
import 'package:grocery_store_app/controllers/product_controller.dart';
import 'package:grocery_store_app/controllers/user_controller.dart';
import 'package:provider/provider.dart';

import 'constants/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckoutController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
