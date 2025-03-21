import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/cart_controller.dart';
import 'package:grocery_store_app/controllers/order_controller.dart';
import 'package:grocery_store_app/models/cart_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'web_view_screen.dart';

class CartScreen extends StatefulWidget {
  final CartModel? cartModel;
  const CartScreen({
    super.key,
    this.cartModel,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCart();
    });
  }

  void loadCart() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      await Provider.of<CartController>(context, listen: false).fetchCarts();
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load Carts: ${e.toString()}';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ///
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Loading...',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
        ),
      );
    }

    ///
    if (_errorMessage != null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Loading...',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text(
          'Keranjang',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      body: Consumer<CartController>(
        builder: (context, cartController, child) {
          final orderController = Provider.of<OrderController>(context);

          return Column(
            children: [
              const Divider(),
              Expanded(
                child: cartController.carts.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_shopping_cart,
                                size: 50, color: Colors.grey),
                            SizedBox(height: 10),
                            Text(
                              'Keranjang kosong',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Tambahkan produk untuk melanjutkan belanja!',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: cartController.carts.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartController.carts[index];
                          int cartId = cartItem.id!;
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery.sizeOf(context).width,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.3,
                                color: Colors.green,
                              ),
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  cartItem.product!.image ??
                                      'https://via.placeholder.com/150',
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.product?.name ??
                                          'Nama tidak tersedia',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    Text(
                                      ('Rp${NumberFormat("#,###", "id_ID").format((cartItem.quantity ?? 0) * (cartItem.product?.price ?? 0))}')
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        try {
                                          await cartController
                                              .removeItem(cartId);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              duration:
                                                  Duration(milliseconds: 100),
                                              content: Text(
                                                  'Item removed successfully'),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              duration:
                                                  Duration(milliseconds: 100),
                                              content:
                                                  Text('Failed to remove item'),
                                            ),
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.delete_outline),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 130,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 0.3,
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cartController
                                                .decreaseQuantity(index);
                                          },
                                          icon: const Icon(Icons.remove),
                                        ),
                                        Text(
                                          (cartItem.quantity!).toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cartController
                                                  .increaseQuantity(index);
                                            },
                                            icon: const Icon(Icons.add))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              /// TOTAL + PAY NOW
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              color: Colors.green[100],
                            ),
                          ),
                          Text(
                            'Rp${NumberFormat("#,###", "id_ID").format(
                              cartController.getTotalPrice(),
                            )}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      /// PAY NOW BUTTON
                      GestureDetector(
                        onTap: () async {
                          final orderUrl = await orderController.checkoutOrder(
                            context,
                            cartController.getTotalPrice(),
                          );

                          if (orderUrl != null && orderUrl.isNotEmpty) {
                            cartController.clearCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 100),
                                content: Text('Checkout berhasil'),
                              ),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewScreen(
                                  midtransUrl: orderUrl,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Checkout gagal'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade100),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Pay Now',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
