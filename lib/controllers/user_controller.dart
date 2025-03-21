import 'package:flutter/material.dart';
import 'package:grocery_store_app/models/user_model.dart';
import 'package:grocery_store_app/services/storage_service.dart';

import '../constants/app_routes.dart';
import '../services/user_service.dart';

class UserController extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchedUser(BuildContext context) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      UserModel? fetchedUser = await _userService.getUser();

      if (fetchedUser == null) {
        _error = 'Failed to load user data';
      } else {
        _user = fetchedUser;
      }
      notifyListeners();
    } catch (e) {
      _error = 'Error : ${e.toString()}';
      print('Error fetching user: $e');
    }
  }

  bool get isLoggedIn => _user != null;

  Future<void> signOut(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    await StorageService.removeToken();

    _user = null;
    _isLoading = false;

    Navigator.pushReplacementNamed(context, AppRoutes.signIn);

    notifyListeners();
  }

  Future<bool> updateUser(
      {required BuildContext context,
      required String name,
      String? password}) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final updateUser = await _userService.updateUser(
        name: name,
        password: password,
      );

      if (updateUser != null) {
        _user = updateUser;
        notifyListeners();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
            ),
          );
        }
        return true;
      } else {
        _error = 'Failed to update';
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update profile'),
            ),
          );
        }
        return false;
      }
    } catch (e) {
      _error = e.toString();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_error!),
          ),
        );
      }
      return false;
    }
  }
}
