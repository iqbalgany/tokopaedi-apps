import 'package:flutter/material.dart';
import 'package:grocery_store_app/model/user_model.dart';
import 'package:grocery_store_app/services/storage_service.dart';
import 'package:grocery_store_app/views/constants/app_routes.dart';

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
}
