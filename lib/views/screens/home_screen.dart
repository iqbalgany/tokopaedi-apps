import 'package:flutter/material.dart';
import 'package:grocery_store_app/controllers/product_controller.dart';
import 'package:grocery_store_app/model/product_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Provider.of<ProductController>(context, listen: false).fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 48,
            ),

            /// GOOD MORNING
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text('Good morning, mate'),
            ),
            const SizedBox(
              height: 4,
            ),

            const SizedBox(
              height: 24,
            ),

            /// DIVIDER
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Divider(),
            ),

            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  ProductModel product = productController.products[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      onTap: () {},
                      leading: Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                      title: Text(
                        product.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.description!,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            product.category!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        'Rp${product.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 0,
            )
          ],
        ),
      ),
    );
  }
}
