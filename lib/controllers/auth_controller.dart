import 'package:flutter/material.dart';
import 'package:grocery_store_app/services/storage_service.dart';
import 'package:grocery_store_app/views/constants/app_routes.dart';

class AuthController extends ChangeNotifier {
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      Navigator.pushReplacementNamed(context, AppRoutes.navbar);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout(BuildContext context) async {
    await StorageService.removeToken();
    Navigator.pushReplacementNamed(context, AppRoutes.signIn);
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
