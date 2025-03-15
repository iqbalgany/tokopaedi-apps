import 'package:flutter/material.dart';
import 'package:grocery_store_app/constants/app_routes.dart';
import 'package:grocery_store_app/controllers/cart_controller.dart';
import 'package:grocery_store_app/controllers/product_controller.dart';
import 'package:grocery_store_app/model/product_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final productController =
          Provider.of<ProductController>(context, listen: false);
      await productController.fetchProducts();
    });

    _scrollController.addListener(
      () {
        final productController =
            Provider.of<ProductController>(context, listen: false);

        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          productController.fetchProducts(isLoadMore: true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    final cartController = Provider.of<CartController>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          ListTile(
            title: Text(
              'Good Morning, Mate',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            trailing: IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
              icon: Icon(Icons.shopping_basket_outlined),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              controller: _scrollController,
              itemCount: productController.products.length + 1,
              itemBuilder: (context, index) {
                if (index < productController.products.length) {
                  ProductModel product = productController.products[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      onTap: () async {
                        await cartController.addToCart(product.id!, 1);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 100),
                            content: Text(
                                cartController.message ?? 'Added to cart!'),
                          ),
                        );
                      },
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
                } else {
                  return productController.hasMore
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
