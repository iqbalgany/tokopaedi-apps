import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';

class CartIcon extends StatelessWidget {
  final int totalItems;
  const CartIcon({
    super.key,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
          icon: const Icon(Icons.shopping_basket_outlined),
        ),
        if (totalItems > 0)
          Positioned(
            right: 4,
            top: 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                textAlign: TextAlign.center,
                totalItems.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
