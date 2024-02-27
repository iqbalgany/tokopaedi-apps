import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  /// LIST OF ITEM ON SALE
  final List _shopItems = [
    // [ itemName, itemPrice, imagePath, color ]
    ['Avocado', '5.00', 'assets/avocado.png', Colors.green],
    ['Banana', '6.00', 'assets/banana.png', Colors.yellow],
    ['Chicken', '10.00', 'assets/chicken.png', Colors.brown],
    ['water', '2.00', 'assets/water.png', Colors.blue],
  ];

  /// LIST OF CART ITEMS
  final List _cartItems = [];

  get shopItems => _shopItems;

  get cartItems => _cartItems;

  ///  ADD ITEM TO CART
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  /// REMOVE ITEM FROM CART
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  /// CALCULATE TOTAL PRICE
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
