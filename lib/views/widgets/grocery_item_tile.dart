import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String description;
  final String itemPrice;
  final String imagePath;
  final int stock;
  final color;
  final Function()? onPressed;
  const GroceryItemTile(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.imagePath,
      required this.onPressed,
      this.color,
      required this.description,
      required this.stock});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                stock.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
            ),

            /// IMAGE
            Image.asset(
              'assets/carrot.png',
              height: 64,
            ),

            /// ITEM NAME
            Text(
              itemName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            ///
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: Colors.black45,
              ),
            ),

            /// PRICE + BUTTON
            MaterialButton(
              onPressed: onPressed,
              color: color[800],
              child: Text(
                '\$$itemPrice',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
