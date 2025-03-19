import 'package:flutter/material.dart';
import 'package:grocery_store_app/views/screens/cart_screen.dart';
import 'package:grocery_store_app/views/screens/detail_order_screen.dart';
import 'package:grocery_store_app/views/screens/home_screen.dart';
import 'package:grocery_store_app/views/screens/order_screen.dart';
import 'package:grocery_store_app/views/screens/signin_screen.dart';
import 'package:grocery_store_app/views/screens/signup_screen.dart';
import 'package:grocery_store_app/views/screens/splash_screen.dart';
import 'package:grocery_store_app/views/screens/web_view_screen.dart';
import 'package:grocery_store_app/views/widgets/navbar.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String home = "/home";
  static const String cart = "/cart";
  static const String product = "/product";
  static const String order = "/order";
  static const String detailOrder = "/detail-order";
  static const String webView = "/web-view";

  /// Bottom Navigation Bar
  static const String navbar = "/navbar";

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    signIn: (context) => const SigninScreen(),
    signUp: (context) => const SignupScreen(),
    cart: (context) => const CartScreen(),
    home: (context) => const HomeScreen(),
    order: (context) => const OrderScreen(),
    detailOrder: (context) => const DetailOrderScreen(),
    webView: (context) => const WebViewScreen(),

    /// Bottom Navigation Bar
    navbar: (context) => const Navbar(),
  };
}
