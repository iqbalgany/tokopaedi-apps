import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/auth_controller.dart';
import 'package:grocery_store_app/controllers/user_controller.dart';
import 'package:grocery_store_app/model/cart_model.dart';
import 'package:grocery_store_app/views/constants/app_routes.dart';
import 'package:provider/provider.dart';

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
          create: (context) => CartModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.signIn,
        routes: AppRoutes.routes,
      ),
    );
  }
}
