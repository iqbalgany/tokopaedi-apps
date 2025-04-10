import 'package:flutter/material.dart';
import 'package:grocery_store_app/models/cart_model.dart';
import 'package:grocery_store_app/services/cart_service.dart';

import '../models/product_model.dart';

class CartController extends ChangeNotifier {
  final CartService _cartService = CartService();
  List<CartModel> _carts = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _message;
  int get totalItems => _carts.fold(
        0,
        (sum, item) => sum + (item.quantity ?? 0),
      );

  List<CartModel> get carts => _carts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get message => _message;

  Future<void> fetchCarts() async {
    _isLoading = true;
    notifyListeners();

    List<CartModel> oldCarts = List.from(_carts);

    List<CartModel> fetchedCarts = await _cartService.getCarts();

    for (var cart in oldCarts) {
      int index = fetchedCarts
          .indexWhere((item) => item.product?.id == cart.product?.id);
      if (index != -1) {
        fetchedCarts[index].quantity = cart.quantity ?? 1;
      }
    }

    _carts = fetchedCarts;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToCart(int productId, int additionalQuantity) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    int index = _carts.indexWhere((item) => item.product?.id == productId);

    if (index != -1) {
      _carts[index].quantity =
          (_carts[index].quantity ?? 0) + additionalQuantity;
    } else {
      _carts.add(CartModel(
        product: ProductModel(
          id: productId,
          price: 0,
        ),
        quantity: additionalQuantity,
      ));
    }

    _message = await _cartService.addToCart(productId, additionalQuantity);

    _isLoading = false;
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _carts[index].quantity = (_carts[index].quantity ?? 0) + 1;
    notifyListeners();

    _isLoading = false;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_carts[index].quantity! > 1) {
      _carts[index].quantity = _carts[index].quantity! - 1;
    } else {
      _carts.removeAt(index);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    return _carts.fold(
      0,
      (sum, item) =>
          sum + ((item.quantity! ?? 0) * (item.product!.price! ?? 0)),
    );
  }

  Future<void> removeItem(int cartId) async {
    _isLoading = true;
    notifyListeners();

    bool success = await _cartService.removeFromCart(cartId);

    _isLoading = false;
    notifyListeners();

    if (success) {
      _carts.removeWhere((item) => item.id == cartId);
      notifyListeners();
    } else {
      throw Exception('Failed to remove item from cart');
    }
  }

  void clearCart() {
    _carts.clear();
    notifyListeners();
  }
}
