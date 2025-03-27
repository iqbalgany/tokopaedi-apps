import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/order_controller.dart';
import 'package:grocery_store_app/views/screens/detail_order_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: orderController.orders.isEmpty
                  ? 8
                  : orderController.orders.length,
              itemBuilder: (context, index) {
                if (orderController.orders.isEmpty) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 30,
                            color: Colors.white,
                          ),
                          Container(
                            width: 100,
                            height: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final order = orderController.orders[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailOrderScreen(orderId: order.id!),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10,
                        index == orderController.orders.length - 1 ? 100 : 5),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}
