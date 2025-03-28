import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store_app/services/auth_service.dart';
import 'package:grocery_store_app/services/storage_service.dart';

import '../constants/app_routes.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      Response? response =
          await _authService.signinService(email: email, password: password);

      if (response != null && response.statusCode == 200) {
        String? token = response.data['data']['access_token'];
        if (token != null) {
          await StorageService.saveToken(token);
          Navigator.pushNamed(context, AppRoutes.navbar);
        }
      }

      notifyListeners();
    } catch (e) {
      throw 'Login gagal, periksa kembali email dan password.';
    }
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

  Future<void> signOut(BuildContext context) async {
    bool success = await _authService.signoutService();

    if (success) {
      await StorageService.removeToken();
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);
    } else {
      throw 'Gagal logout. coba lagi nanti';
    }
  }
}
