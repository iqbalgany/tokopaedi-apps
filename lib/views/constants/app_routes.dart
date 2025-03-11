import 'package:flutter/material.dart';
import 'package:grocery_store_app/views/screens/home_screen.dart';
import 'package:grocery_store_app/views/screens/signin_screen.dart';
import 'package:grocery_store_app/views/screens/signup_screen.dart';
import 'package:grocery_store_app/views/widgets/navbar.dart';

class AppRoutes {
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String home = "/home";
  // static const String onboarding = "/onboarding";
  // static const String getStarted = "/get-started";
  // static const String tnc = "/tnc";
  // static const String home = "/home";
  // static const String tukarPulsa = "/tukar-pulsa";
  // static const String tukarPulsaCheck = "/tukar-pulsa-check";
  // static const String tukarPulsaInvoice = "/tukar-pulsa-invoice";
  // static const String rekeningList = "/rekening-list";
  // static const String inbox = "/inbox";
  // static const String activity = "/activity";
  // static const String activityStatus = "/activity-status";
  // static const String activityStatusPending = "/activity-status-pending";
  // static const String bankAccount = "/bank-account";
  // static const String addBankAccount = "/add-bank-account";
  // static const String editBankAccount = "/edit-bank-account";
  // static const String bankList = "/bank-list";
  // static const String profile = "/profile";
  // static const String contact = "/contact";
  // static const String chat = "/chat";
  static const String navbar = "/navbar";

  static Map<String, WidgetBuilder> routes = {
    signIn: (context) => const SigninScreen(),
    signUp: (context) => const SignupScreen(),
    home: (context) => const HomeScreen(),
    // splash: (context) => SplashScreen(),
    // onboarding: (context) => OnboardingScreen(),
    // getStarted: (context) => GetStartedScreen(),
    // tnc: (context) => TNCScreen(),
    // home: (context) => HomeScreen(),
    // tukarPulsa: (context) => TukarPulsaScreen(),
    // tukarPulsaCheck: (context) => TukarPulsaCheckScreen(),
    // tukarPulsaInvoice: (context) => TukarPulsaInvoiceScreen(),
    // rekeningList: (context) => DaftarRekeningScreen(),
    // inbox: (context) => InboxScreen(),
    // activity: (context) => ActivityScreen(),
    // activityStatus: (context) => ActivityStatusScreen(),
    // activityStatusPending: (context) => ActivityStatusPendingScreen(),
    // bankAccount: (context) => RekeningScreen(),
    // addBankAccount: (context) => TambahRekeningScreen(),
    // editBankAccount: (context) => UbahRekeningScreen(),
    // bankList: (context) => DaftarBankScreen(),
    // profile: (context) => ProfileScreen(),
    // contact: (context) => ContactScreen(),
    // chat: (context) => ChatScreen(),

    // /// Bottom Navigation Bar
    navbar: (context) => const Navbar(),
  };
}
