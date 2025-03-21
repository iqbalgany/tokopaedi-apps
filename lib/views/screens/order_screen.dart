import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/order_controller.dart';
import 'package:grocery_store_app/views/screens/detail_order_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderController>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderController = Provider.of<OrderController>(context);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),

          ///
          Expanded(
            child: orderController.orders.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.remove_shopping_cart,
                            size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          'Order kosong',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Silahkan berbelanja telebih dahulu!',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: orderController.orders.length,
                    itemBuilder: (context, index) {
                      final order = orderController.orders[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailOrderScreen(orderId: order.id!),
                            )),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.green,
                            ),
                          ),
                          child: Column(
                            children: [
                              ///
                              Row(
                                children: [
                                  const Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 7),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Belanja',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd MMM yyyy')
                                            .format(order.createdAt!),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: orderController
                                            .getStatusColor(order.status!),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      order.status!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: orderController
                                            .getStatusTextColor(order.status!),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(),

                              ///
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.code!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '${order.orderItems!.length} barang',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),

                              ///
                              Row(
                                children: [
                                  const Text(
                                    'Total Belanja : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Rp${NumberFormat("#,###", "id_ID").format(order.totalPrice).toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
