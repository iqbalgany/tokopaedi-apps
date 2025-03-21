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
        } else {
          print("Token null, periksa response API.");
        }

        Navigator.pushReplacementNamed(context, AppRoutes.navbar);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login gagal, periksa kembali email dan password.'),
          ),
        );
      }

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: ${e.toString()}'),
        ),
      );
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
