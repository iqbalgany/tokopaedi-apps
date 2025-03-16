import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/cart_controller.dart';
import 'package:grocery_store_app/model/cart_model.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Provider.of<CartController>(context, listen: false).fetchCarts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_sharp),
        ),
        title: Text(
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
          if (cartController.cartModel.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart,
                      size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'Keranjang kosong',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tambahkan produk untuk melanjutkan belanja!',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Divider(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: cartController.cartModel.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartController.cartModel[index];
                    int cartId = cartItem.id!;
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5),
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
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.product?.name ?? 'Nama tidak tersedia',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black45,
                                ),
                              ),
                              Text(
                                ('Rp${(cartItem.quantity ?? 0) * (cartItem.product?.price ?? 0)}')
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () async {
                                  try {
                                    await cartController.removeItem(cartId);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(milliseconds: 100),
                                        content:
                                            Text('Item removed successfully'),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(milliseconds: 100),
                                        content: Text('Failed to remove item'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                          Spacer(),
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
                                        cartController.decreaseQuantity(index);
                                      },
                                      icon: Icon(Icons.remove)),
                                  Text(
                                    (cartItem.quantity!).toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cartController.increaseQuantity(index);
                                      },
                                      icon: Icon(Icons.add))
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
            ],
          );
        },
      ),
      //   body: Consumer<CartModel>(
      //   builder: (context, value, child) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SizedBox(height: 50),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 24),
      //           child: Text(
      //             'My Cart',
      //             style: GoogleFonts.notoSerif(
      //               fontSize: 36,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),

      //         /// LIST OF CART ITEMS
      //         Expanded(
      //           child: ListView.builder(
      //             itemCount: value.cartItems.length,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 margin: const EdgeInsets.all(12),
      //                 decoration: BoxDecoration(
      //                   border: Border.all(
      //                     color: Colors.green,
      //                   ),
      //                   borderRadius: BorderRadius.circular(8),
      //                 ),
      //                 child: ListTile(
      //                   leading: Image.asset(value.cartItems[index][2]),
      //                   title: Text(
      //                     value.cartItems[index][1],
      //                   ),
      //                   subtitle: Text('\$' + value.cartItems[index][1]),
      //                   trailing: IconButton(
      //                     onPressed: () {
      //                       Provider.of<CartModel>(context, listen: false)
      //                           .removeItemFromCart(index);
      //                     },
      //                     icon: const Icon(Icons.cancel),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),

      //         /// TOTAL + PAY NOW
      //         Padding(
      //           padding: const EdgeInsets.fromLTRB(36, 36, 36, 120),
      //           child: Container(
      //             padding: const EdgeInsets.all(24),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(12),
      //               color: Colors.green,
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text('Total Price',
      //                         style: TextStyle(
      //                           color: Colors.green[100],
      //                         )),
      //                     // Text(
      //                     //   '\$${value.calculateTotal()}',
      //                     //   style: const TextStyle(
      //                     //       color: Colors.white,
      //                     //       fontSize: 18,
      //                     //       fontWeight: FontWeight.bold),
      //                     // ),
      //                   ],
      //                 ),

      //                 /// PAY NOW BUTTON
      //                 Container(
      //                   padding: const EdgeInsets.all(12),
      //                   margin: EdgeInsets.only(),
      //                   decoration: BoxDecoration(
      //                     border: Border.all(color: Colors.green.shade100),
      //                     borderRadius: BorderRadius.circular(12),
      //                   ),
      //                   child: const Row(
      //                     children: [
      //                       Text(
      //                         'Pay Now',
      //                         style: TextStyle(
      //                           color: Color.fromARGB(255, 94, 12, 12),
      //                         ),
      //                       ),
      //                       Icon(
      //                         Icons.arrow_forward_ios,
      //                         size: 16,
      //                         color: Colors.white,
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // )
    );
  }
}
