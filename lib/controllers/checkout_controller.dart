import 'package:flutter/material.dart';
import 'package:grocery_store_app/model/checkout_model.dart';
import 'package:grocery_store_app/services/checkout_service.dart';

class CheckoutController extends ChangeNotifier {
  final CheckoutService _checkoutService = CheckoutService();

  CheckoutModel? _checkout;
  bool _isLoading = false;

  CheckoutModel? get checkout => _checkout;
  bool get isLoading => _isLoading;

  Future<void> checkoutOrder() async {
    _isLoading = true;
    notifyListeners();

    _checkout = await _checkoutService.checkoutOrder();

    _isLoading = false;
    notifyListeners();
  }
}
