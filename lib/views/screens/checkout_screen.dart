import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/checkout_controller.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController = Provider.of<CheckoutController>(context);
    return Scaffold(
      body: checkoutController.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Checkout Now',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
    );
  }
}
